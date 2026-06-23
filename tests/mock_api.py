#!/usr/bin/env python3
"""Tiny mock ise-api used by tests/validate.sh."""

from __future__ import annotations

import json
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer

MANIFEST = {
    "name": "mock-ise-api",
    "publisher": "test",
    "snapshots": [
        {
            "name": "startups",
            "file": "startups.json",
            "cadence": "live",
            "available": True,
            "queryable": True,
        },
        {
            "name": "macro",
            "file": "macro.json",
            "cadence": "intraday",
            "available": True,
            "queryable": True,
        },
    ],
}

STARTUPS = {
    "generatedAt": "2026-01-01T00:00:00.000Z",
    "kpis": {
        "startups": {"value": 1, "delta24h": 0},
        "openJobs": 0,
    },
}


class Handler(BaseHTTPRequestHandler):
    def do_GET(self) -> None:  # noqa: N802
        if self.path == "/healthz":
            self._json({"status": "ok"})
        elif self.path == "/snapshots":
            self._json(MANIFEST)
        elif self.path == "/snapshots/startups":
            self._json(STARTUPS)
        else:
            self.send_error(404)

    def _json(self, payload: dict) -> None:
        body = json.dumps(payload).encode("utf-8")
        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, format: str, *args) -> None:  # noqa: A003
        return


if __name__ == "__main__":
    server = ThreadingHTTPServer(("127.0.0.1", 8765), Handler)
    server.serve_forever()
