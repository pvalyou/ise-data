#!/usr/bin/env bash
# Commit changed snapshots, only if something actually changed, with a
# delta-aware message so each commit headline shows what moved.
#
# Env:
#   CADENCE   cadence tier label for the commit subject (default live)
set -euo pipefail

CADENCE="${CADENCE:-live}"
OUT_DIR="snapshot"
TS="$(date -u +'%Y-%m-%dT%H:%M:%SZ')"

git add "$OUT_DIR"

if git diff --cached --quiet; then
  echo "No snapshot changes to commit."
  exit 0
fi

changed=()
while IFS= read -r path; do
  changed+=("$path")
done < <(git diff --cached --name-only -- "$OUT_DIR")
count="${#changed[@]}"

subject="snapshot(${CADENCE}): update ${count} file(s) - ${TS}"

body="Changed files:"
for f in "${changed[@]}"; do
  body+=$'\n'"  - ${f}"
done

# If the headline startups snapshot changed, surface the KPI deltas.
if printf '%s\n' "${changed[@]}" | grep -qx "${OUT_DIR}/startups.json"; then
  prev="$(git show "HEAD:${OUT_DIR}/startups.json" 2>/dev/null || echo '{}')"
  curr="$(cat "${OUT_DIR}/startups.json")"
  delta="$(
    jq -n --argjson a "$prev" --argjson b "$curr" '
      def g(p): (try (p) catch null);
      {
        startups: { from: ($a.kpis.startups.value // null), to: ($b.kpis.startups.value // null) },
        openJobs: { from: ($a.kpis.openJobs // null),        to: ($b.kpis.openJobs // null) },
        exits:    { from: ($a.kpis.exits.count // null),     to: ($b.kpis.exits.count // null) }
      }' 2>/dev/null || echo '{}'
  )"
  if [ "$delta" != "{}" ]; then
    body+=$'\n\n'"KPI deltas (startups):"
    body+=$'\n'"$(echo "$delta" | jq -r '
      to_entries[] | "  - \(.key): \(.value.from) -> \(.value.to)"')"
  fi
fi

git commit -m "$subject" -m "$body"
echo "Committed: $subject"
