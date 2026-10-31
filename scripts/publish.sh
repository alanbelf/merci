#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
command -v gh >/dev/null || { echo "Install GitHub CLI first: https://cli.github.com/"; exit 1; }
gh auth status >/dev/null
[[ "$(git branch --show-current)" == "main" ]] || { echo "Publish from main only."; exit 1; }
[[ -z "$(git status --porcelain)" ]] || { echo "Working tree must be clean."; exit 1; }
[[ -f scripts/.last-approved-sha ]] || { echo "Run npm run approve first."; exit 1; }
approved="$(cat scripts/.last-approved-sha)"
current="$(git rev-parse HEAD)"
remote="$(git ls-remote origin refs/heads/main | awk '{print $1}')"
[[ "$current" == "$approved" && "$current" == "$remote" ]] || {
  echo "Current commit is not the last approved commit. Approve again."; exit 1;
}
gh workflow run deploy.yml --ref main
sleep 3
run_id="$(gh run list --workflow deploy.yml --branch main --limit 1 --json databaseId --jq '.[0].databaseId')"
[[ -n "$run_id" && "$run_id" != "null" ]] || { echo "Could not find deployment run."; exit 1; }
gh run watch "$run_id" --exit-status
if [[ -f scripts/.last-published-sha ]]; then
  cp scripts/.last-published-sha scripts/.previous-published-sha
fi
printf '%s\n' "$current" > scripts/.last-published-sha
echo "Deployment succeeded: $current"
