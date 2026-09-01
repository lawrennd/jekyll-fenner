---
id: "2026-09-01_cip0001-readme-scope"
title: "CIP-0001: Update README scope from survey manifest"
status: "Completed"
priority: "Medium"
created: "2026-09-01"
last_updated: "2026-09-01"
category: "documentation"
related_cips: ["0001"]
owner: "Neil Lawrence"
dependencies:
  - "2026-09-01_cip0001-synthesis-manifest"
tags:
  - backlog
  - survey
  - cip0001
  - documentation
---

# Task: Update README scope from survey manifest (CIP-0001 phase E)

## Description

Replace provisional in-scope / out-of-scope lists in the Fenner README with
survey-backed paths from `fenner-owned-paths.txt`. Makes the install contract
auditable for theme maintainers.

## Acceptance Criteria

- [x] README scope section references the manifest (or embeds its path list).
- [x] Chrome vs content boundary matches synthesis decisions (REQ-0001).
- [x] No contradiction with CIP-0002 install behaviour once manifest is fixed.

## Implementation Notes

Run after synthesis manifest is reviewed. Keep README concise — link to
`cip/cip0001/fenner-owned-paths.txt` for the full list rather than duplicating
every path inline unless compression warrants it.

## Related

- CIP: 0001
- Deliverable: README scope section update

## Progress Updates

### 2026-09-01

Completed. README scope and status sections updated from manifest.
