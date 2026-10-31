#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
branch="$(git branch --show-current)"
[[ "$branch" == "main" ]] || { echo "Switch to main before approval."; exit 1; }
npm run check:all
git status --short
echo
read -r -p "Have you reviewed these exact changes? Type APPROVE: " answer
[[ "$answer" == "APPROVE" ]] || { echo "Approval cancelled."; exit 1; }
if [[ -n "$(git status --porcelain)" ]]; then
  git add -A
  git commit -m "Update Merci Concierge website"
fi
git push origin main
git rev-parse HEAD > scripts/.last-approved-sha
echo "Changes pushed to main and marked as approved."
