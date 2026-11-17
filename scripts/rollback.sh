#!/usr/bin/env bash
# Undo the last published update.
# Creates a new commit that reverses it, pushes to `main`, and GitHub Actions
# redeploys the previous version of the site. History is kept; nothing is erased.
# Running it again undoes the undo.
#
# Usage: scripts/rollback.sh [--yes] [commit]
#   --yes, -y   skip the confirmation question
#   commit      revert this commit instead of the latest one
set -euo pipefail

cd "$(dirname "$0")/.."

WORKFLOW="deploy-hostinger.yml"
SITE_URL="https://merciconcierge.com"
ASSUME_YES=0
TARGET="HEAD"

die() { echo "❌ $*" >&2; exit 1; }

for arg in "$@"; do
  case "$arg" in
    --yes|-y) ASSUME_YES=1 ;;
    -*) die "Unknown option: $arg" ;;
    *) TARGET="$arg" ;;
  esac
done

command -v git >/dev/null 2>&1 || die "git is not installed."

# Wait for the GitHub Actions run of the commit we just pushed (needs the `gh` CLI).
watch_deploy() {
  local sha repo_url run_id=""
  sha=$(git rev-parse HEAD)
  repo_url=$(git remote get-url origin | sed -E 's#^git@github\.com:#https://github.com/#; s#\.git$##')
  echo "→ Deployment progress: ${repo_url}/actions"

  if ! command -v gh >/dev/null 2>&1 || ! gh auth status >/dev/null 2>&1; then
    echo "ℹ️  Cannot follow the deployment from here. Open the link above:"
    echo "    a green check means the previous version is live at ${SITE_URL}"
    return 0
  fi

  for _ in $(seq 1 15); do
    run_id=$(gh run list --workflow "$WORKFLOW" --commit "$sha" --limit 1 \
      --json databaseId --jq '.[0].databaseId' 2>/dev/null || true)
    [ -n "$run_id" ] && break
    sleep 2
  done

  if [ -z "$run_id" ]; then
    echo "ℹ️  No deployment was triggered. Check ${repo_url}/actions"
    return 0
  fi

  echo "→ Waiting for the deployment to finish..."
  if gh run watch "$run_id" --exit-status >/dev/null 2>&1; then
    echo "✅ Previous version restored: ${SITE_URL}"
  else
    die "Deployment FAILED. Details: ${repo_url}/actions/runs/${run_id}"
  fi
}

branch=$(git rev-parse --abbrev-ref HEAD)
[ "$branch" = "main" ] || die "You are on branch '$branch'. Undo is only done from 'main'."

[ -z "$(git status --porcelain)" ] \
  || die "You have changes that are not published yet. Publish them, or discard them, then try again."

echo "→ Syncing with GitHub..."
git fetch origin main --quiet
if [ "$(git rev-list --count HEAD..origin/main)" != "0" ]; then
  git pull --ff-only --quiet origin main \
    || die "Could not update from GitHub. Ask the maintainer for help."
fi

git rev-parse --verify --quiet "${TARGET}^{commit}" >/dev/null || die "Unknown commit: $TARGET"

echo "This update will be undone:"
git log -1 --date=format:'%Y-%m-%d %H:%M' --format='   %h  %ad  %s' "$TARGET"

if [ "$ASSUME_YES" != "1" ]; then
  read -r -p "Undo it and republish the previous version? [y/N] " answer
  case "$answer" in
    y|Y|yes|YES) ;;
    *) echo "Cancelled. Nothing was changed."; exit 0 ;;
  esac
fi

revert_args=(--no-edit)
# A merge commit needs to know which parent to keep.
if [ "$(git rev-list --parents -n 1 "$TARGET" | wc -w)" -gt 2 ]; then
  revert_args+=(-m 1)
fi

if ! git revert "${revert_args[@]}" "$TARGET"; then
  git revert --abort >/dev/null 2>&1 || true
  die "Could not undo this update automatically. Nothing was changed. Ask the maintainer for help."
fi

echo "→ Republishing..."
git push --quiet origin main

watch_deploy
