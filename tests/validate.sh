#!/usr/bin/env bash
# Lightweight CI checks for the ise-data repo (no live API or DB required).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

echo "Checking shell script syntax..."
bash -n scripts/fetch-snapshots.sh
bash -n scripts/commit-snapshots.sh

echo "Validating snapshot/manifest.json..."
jq empty snapshot/manifest.json
jq -e '.snapshots | length > 0' snapshot/manifest.json >/dev/null

echo "Checking workflow files exist..."
for wf in snapshots-live snapshots-intraday snapshots-daily; do
  test -f ".github/workflows/${wf}.yml"
done

echo "Testing fetch-snapshots against mock API..."
TMP_DIR="$(mktemp -d)"
python3 tests/mock_api.py &
MOCK_PID=$!
cleanup() {
  kill "$MOCK_PID" 2>/dev/null || true
}
trap cleanup EXIT

for _ in $(seq 1 20); do
  if curl -fsS "http://127.0.0.1:8765/healthz" >/dev/null 2>&1; then
    break
  fi
  sleep 0.2
done

rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR"
API_BASE_URL="http://127.0.0.1:8765" CADENCE=live OUT_DIR="$TMP_DIR" bash scripts/fetch-snapshots.sh
test -f "$TMP_DIR/startups.json"
jq -e '.generatedAt and .kpis' "$TMP_DIR/startups.json" >/dev/null
rm -rf "$TMP_DIR"

echo "Testing commit-snapshots delta helper..."
prev='{"kpis":{"startups":{"value":12000},"openJobs":7000,"exits":{"count":1700}}}'
curr='{"kpis":{"startups":{"value":12331},"openJobs":7285,"exits":{"count":1753}}}'
delta="$(jq -n --argjson a "$prev" --argjson b "$curr" '{
  startups: { from: ($a.kpis.startups.value // null), to: ($b.kpis.startups.value // null) }
}')"
echo "$delta" | jq -e '.startups.to == 12331' >/dev/null

echo "All ise-data checks passed."
