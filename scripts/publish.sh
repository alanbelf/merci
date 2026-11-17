#!/usr/bin/env bash
# Publish the website.
# Runs the checks, commits the current changes and pushes to `main`.
# GitHub Actions then builds the site and uploads it to Hostinger.
#
# Usage: scripts/publish.sh ["short description of the change"]
set -euo pipefail

cd "$(dirname "$0")/.."

WORKFLOW="deploy-hostinger.yml"
SITE_URL="https://merciconcierge.com"
MSG="${1:-}"

die() { echo "❌ $*" >&2; exit 1; }

command -v git >/dev/null 2>&1 || die "git is not installed."
command -v npm >/dev/null 2>&1 || die "npm is not installed."

# Wait for the GitHub Actions run of the commit we just pushed (needs the `gh` CLI).
watch_deploy() {
  local sha repo_url run_id=""
  sha=$(git rev-parse HEAD)
  repo_url=$(git remote get-url origin | sed -E 's#^git@github\.com:#https://github.com/#; s#\.git$##')
  echo "→ Deployment progress: ${repo_url}/actions"

  if ! command -v gh >/dev/null 2>&1 || ! gh auth status >/dev/null 2>&1; then
    echo "ℹ️  Cannot follow the deployment from here. Open the link above:"
    echo "    a green check means the site is live at ${SITE_URL}"
    return 0
  fi

  for _ in $(seq 1 15); do
    run_id=$(gh run list --workflow "$WORKFLOW" --commit "$sha" --limit 1 \
      --json databaseId --jq '.[0].databaseId' 2>/dev/null || true)
    [ -n "$run_id" ] && break
    sleep 2
  done

  if [ -z "$run_id" ]; then
    echo "ℹ️  No deployment was triggered (documentation-only change?)."
    return 0
  fi

  echo "→ Waiting for the deployment to finish..."
  if gh run watch "$run_id" --exit-status >/dev/null 2>&1; then
    echo "✅ Published: ${SITE_URL}"
  else
    die "Deployment FAILED. Details: ${repo_url}/actions/runs/${run_id}"
  fi
}

branch=$(git rev-parse --abbrev-ref HEAD)
[ "$branch" = "main" ] || die "You are on branch '$branch'. Publishing is only done from 'main'."

echo "→ Syncing with GitHub..."
git fetch origin main --quiet
if [ "$(git rev-list --count HEAD..origin/main)" != "0" ]; then
  git pull --ff-only --quiet origin main \
    || die "Could not update from GitHub. Ask the maintainer for help."
fi

if [ -z "$(git status --porcelain)" ] && [ "$(git rev-list --count origin/main..HEAD)" = "0" ]; then
  echo "Nothing to publish: there are no changes."
  exit 0
fi

# Safety: site content only. Infrastructure and secrets need the maintainer.
if [ "${ALLOW_INFRA:-0}" != "1" ]; then
  blocked=$(git status --porcelain | sed 's/^...//' \
    | grep -E '^"?(\.github/|scripts/|astro\.config\.|package(-lock)?\.json|public/\.htaccess|\.env)' || true)
  if [ -n "$blocked" ]; then
    echo "$blocked" | sed 's/^/   /' >&2
    die "These files are not site content and need the maintainer's approval (set ALLOW_INFRA=1 to override)."
  fi
fi

[ -d node_modules ] || { echo "→ Installing dependencies..."; npm ci; }

echo "→ Running checks (this can take a minute)..."
npm run check:all

echo "→ Changes to publish:"
git status --short

git add -A
if ! git diff --cached --quiet; then
  [ -n "$MSG" ] || MSG="Update website ($(date '+%Y-%m-%d %H:%M'))"
  git commit --quiet -m "$MSG"
fi

echo "→ Publishing..."
git push --quiet origin main

watch_deploy
