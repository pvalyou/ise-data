#!/usr/bin/env bash
# Fetch snapshots from ise-api and write them under snapshot/.
#
# Self-adjusting: it reads the API manifest and only fetches snapshots that the
# API reports as available AND whose cadence matches $CADENCE. New snapshots
# light up automatically as they are implemented in ise-api.
#
# Env:
#   API_BASE_URL  base URL of ise-api, e.g. https://ise-api-srv-xxxx.run.app
#   CADENCE       cadence tier to fetch: live | intraday | daily (default live)
set -euo pipefail

API_BASE_URL="${API_BASE_URL:?API_BASE_URL is required}"
CADENCE="${CADENCE:-live}"
OUT_DIR="${OUT_DIR:-snapshot}"

mkdir -p "$OUT_DIR"

echo "Fetching manifest from $API_BASE_URL/snapshots ..."
manifest="$(curl -fsS --max-time 30 "$API_BASE_URL/snapshots")"

# Mirror the manifest for consumers.
echo "$manifest" | jq '.' > "$OUT_DIR/manifest.json"

names=()
while IFS= read -r name; do
  names+=("$name")
done < <(
  echo "$manifest" |
  jq -r --arg cad "$CADENCE" \
    '.snapshots[] | select(.available == true and .cadence == $cad) | .name'
)

if [ "${#names[@]}" -eq 0 ]; then
  echo "No available snapshots for cadence=$CADENCE. Nothing to do."
  exit 0
fi

for name in "${names[@]}"; do
  echo "Fetching $name ..."
  tmp="$(mktemp)"
  if ! curl -fsS --max-time 120 "$API_BASE_URL/snapshots/$name" -o "$tmp"; then
    echo "WARN: fetch failed for $name, skipping" >&2
    rm -f "$tmp"
    continue
  fi
  # Validate it is well-formed JSON before committing.
  if ! jq empty "$tmp" 2>/dev/null; then
    echo "WARN: invalid JSON for $name, skipping" >&2
    rm -f "$tmp"
    continue
  fi
  jq '.' "$tmp" > "$OUT_DIR/$name.json"
  rm -f "$tmp"
  echo "  wrote $OUT_DIR/$name.json"
done

echo "Done."
