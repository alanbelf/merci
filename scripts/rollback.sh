#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
command -v gh >/dev/null || { echo "Install GitHub CLI first."; exit 1; }
gh auth status >/dev/null
[[ "$(git branch --show-current)" == "main" ]] || { echo "Rollback from main only."; exit 1; }
[[ -z "$(git status --porcelain)" ]] || { echo "Working tree must be clean."; exit 1; }
[[ -f scripts/.previous-published-sha ]] || { echo "No previous deployment recorded on this computer."; exit 1; }
previous="$(cat scripts/.previous-published-sha)"
current="$(git rev-parse HEAD)"
read -r -p "This creates a new commit reverting to $previous. Type ROLLBACK: " answer
[[ "$answer" == "ROLLBACK" ]] || { echo "Rollback cancelled."; exit 1; }
git revert --no-edit "$current"
git push origin main
git rev-parse HEAD > scripts/.last-approved-sha
gh workflow run deploy.yml --ref main
sleep 3
run_id="$(gh run list --workflow deploy.yml --branch main --limit 1 --json databaseId --jq '.[0].databaseId')"
[[ -n "$run_id" && "$run_id" != "null" ]] || { echo "Could not find deployment run."; exit 1; }
gh run watch "$run_id" --exit-status
echo "Rollback deployment succeeded. Verify the live website."
