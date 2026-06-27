#!/usr/bin/env bash
# Lightweight CI checks for committed snapshot JSON (no live API or DB required).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

echo "Validating snapshot/manifest.json..."
jq empty snapshot/manifest.json
jq -e '.snapshots | length > 0' snapshot/manifest.json >/dev/null

echo "Validating committed snapshot files..."
while IFS= read -r entry; do
  name="$(echo "$entry" | jq -r '.name')"
  available="$(echo "$entry" | jq -r '.available')"
  if [ "$available" != "true" ]; then
    continue
  fi
  path="snapshot/${name}.json"
  test -f "$path"
  jq empty "$path"
  echo "  ok $path"
done < <(jq -c '.snapshots[]' snapshot/manifest.json)

echo "All ise-data checks passed."
