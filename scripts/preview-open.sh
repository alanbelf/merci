#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
if ! curl -fsS http://localhost:4321/ >/dev/null 2>&1; then
  nohup npm run dev -- --host 127.0.0.1 > /tmp/merci-concierge-astro.log 2>&1 &
  echo "Starting Astro preview..."
  for _ in {1..30}; do
    if curl -fsS http://localhost:4321/ >/dev/null 2>&1; then break; fi
    sleep 1
  done
fi
open "http://localhost:4321/merci-concierge/"
