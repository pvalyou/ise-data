# ise-data

Open, machine-readable snapshots of the Israeli startup ecosystem, published by
Pvalyou. These JSON files power the live dashboard and are the same data it
reads. Everything is built from public information, gathered and structured by
Pvalyou, and refreshed automatically.

The numbers live here. The full guide to reading them is in `snapshot/SKILL.md`,
and a machine index is in `snapshot/manifest.json`.

## Consume the data

No API key, no rate limit, no server. Just read the JSON.

- Raw GitHub: `https://raw.githubusercontent.com/pvalyou/ise-data/main/snapshot/startups.json`
- CDN (cached, faster): `https://cdn.jsdelivr.net/gh/pvalyou/ise-data@main/snapshot/startups.json`

Start from `snapshot/manifest.json` to discover every file.

## Use it with an AI assistant

`snapshot/SKILL.md` is a ready-to-install skill that teaches an assistant how to
read these files, with every metric and the operating definitions.

- Claude Code: copy it into `~/.claude/skills/israeli-ecosystem-snapshots/`, or
  `.claude/skills/` in a project. It loads automatically.
- claude.ai: Settings, Features, upload the skill folder as a zip.
- Claude API: upload via the `/v1/skills` endpoint, reference it with code execution.
- Other agents (Cursor, Gemini CLI, Codex CLI): drop `SKILL.md` in their skills folder.
- Any other assistant: paste `SKILL.md` as a custom instruction, attach `manifest.json`.

## How it updates

Scheduled workflows export from Postgres and commit here, only when content
changes. Every refresh is a commit, so the git history is the changelog.

| Tier | Cadence |
| --- | --- |
| live | every 15 min |
| intraday | hourly |
| daily | daily |

`network.json` and `embedding-map.*` are visualization geometry for the
interactive views. For figures, use the other files.

## License

CC BY-NC 4.0. Free to use and share with attribution to Pvalyou, for
non-commercial purposes. Reselling the data or building a paid product on it is
not permitted. See `LICENSE`.

## Citation

Credit Pvalyou. A machine-readable `CITATION.cff` is included. Recommended form:
Pvalyou. Israeli Startup Ecosystem, Open Snapshots. https://pvalyou.com (accessed YYYY-MM-DD).

## Contact

val@pvalyou.com
