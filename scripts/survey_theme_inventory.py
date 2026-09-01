#!/usr/bin/env python3
"""Fetch consumer theme files from GitHub and build survey-matrix.csv (CIP-0001)."""

from __future__ import annotations

import csv
import hashlib
import re
import sys
import urllib.error
import urllib.request
from pathlib import Path

BASELINE = "lawrennd"

THEMES: dict[str, str] = {
    "lawrennd": "main",
    "mlatcl": "main",
    "uk-ai": "main",
    "datatrustsinitiative": "main",
    "acceleratescience": "main",
    "aistats": "master",
    "gpschool": "master",
    "mlresearch": "master",
    "mlr-datasets": "master",
    "dalimeeting": "dali",
    "rs-delve": "main",
}

CHECKLIST = [
    "_layouts/publication.html",
    "_layouts/article.html",
    "_layouts/inproceedings.html",
    "_layouts/techreport.html",
    "_includes/paper_authors_abstract_links.html",
    "_includes/paper_abstract.html",
    "_includes/cite-as.html",
    "_includes/listpaper.html",
    "_includes/listauthors.html",
    "_includes/seo-info.html",
    "_includes/extractinfo_publication.html",
    "_includes/extractname.html",
    "_includes/copy_sections.html",
    "_includes/bibtex_copy_section.html",
    "_includes/apa_copy_section.html",
    "_includes/ris_copy_section.html",
    "_includes/endnote_copy_section.html",
    "_includes/bibtex_entry",
    "_includes/apa_entry",
    "_includes/ris_entry",
    "_includes/endnote_entry",
    "_includes/copy_buttons.html",
    "_includes/hidden_copy_code.html",
    "_includes/paper_google_scholar.html",
    "_includes/paper_open_graph_meta.html",
    "_includes/paper_twitter_meta.html",
    "assets/bib/citeproc.yaml",
]

RAW = "https://raw.githubusercontent.com/{org}/jekyll-theme/{branch}/{path}"


def fetch(org: str, branch: str, path: str) -> bytes | None:
    url = RAW.format(org=org, branch=branch, path=path)
    try:
        with urllib.request.urlopen(url, timeout=30) as resp:
            return resp.read()
    except urllib.error.HTTPError as exc:
        if exc.code == 404:
            return None
        raise


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def layout_parent(content: bytes) -> str:
    text = content.decode("utf-8", errors="replace")
    match = re.search(r"^layout:\s*(\S+)", text, re.MULTILINE)
    return match.group(1) if match else ""


def article_wiring(content: bytes) -> str:
    text = content.decode("utf-8", errors="replace")
    parent = layout_parent(content)
    includes = re.findall(r"{%\s*include\s+([^\s%]+)", text)
    body = includes[0] if includes else ""
    return f"layout={parent}; body={body}"


def main() -> int:
    out_path = Path(__file__).resolve().parents[1] / "cip" / "cip0001" / "survey-matrix.csv"
    out_path.parent.mkdir(parents=True, exist_ok=True)

    baseline_branch = THEMES[BASELINE]
    hashes: dict[str, str | None] = {}
    contents: dict[str, bytes | None] = {}

    for path in CHECKLIST:
        data = fetch(BASELINE, baseline_branch, path)
        contents[path] = data
        hashes[path] = sha256(data) if data is not None else None

    rows: list[dict[str, str]] = []
    for org, branch in THEMES.items():
        for path in CHECKLIST:
            data = fetch(org, branch, path)
            if data is None:
                status = "MISSING"
                note = ""
            elif hashes[path] is None:
                status = "EXTRA_BASELINE_MISSING"
                note = ""
            elif sha256(data) == hashes[path]:
                status = "IDENTICAL"
                note = ""
            else:
                status = "DIFFERS"
                note = ""
            if path == "_layouts/article.html" and data is not None:
                note = article_wiring(data)
            rows.append(
                {
                    "theme": org,
                    "branch": branch,
                    "path": path,
                    "status": status,
                    "note": note,
                }
            )

    with out_path.open("w", newline="", encoding="utf-8") as fh:
        writer = csv.DictWriter(
            fh, fieldnames=["theme", "branch", "path", "status", "note"]
        )
        writer.writeheader()
        writer.writerows(rows)

    print(f"Wrote {out_path} ({len(rows)} rows)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
