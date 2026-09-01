---
id: "2026-09-01_cip0001-snapshot-inventory"
title: "CIP-0001: Automate theme snapshot inventory"
status: "Ready"
priority: "High"
created: "2026-09-01"
last_updated: "2026-09-01"
category: "features"
related_cips: ["0001"]
owner: "Neil Lawrence"
dependencies: []
tags:
  - backlog
  - survey
  - cip0001
---

# Task: Automate theme snapshot inventory (CIP-0001 phase A)

## Description

Build a repeatable snapshot of the eleven public consumer Jekyll themes on their
GitHub default branches. Compare Fenner-relevant paths (`_layouts`, publication
includes, `assets/bib/citeproc.yaml`, etc.) and record whether each file is
IDENTICAL, DIFFERS, MISSING, or EXTRA per theme.

Output feeds the synthesis workshop and the `fenner-owned-paths.txt` manifest
for CIP-0002.

## Acceptance Criteria

- [ ] Script or documented shell recipe can reproduce the inventory from GitHub
      (or fresh local checkouts).
- [ ] `cip/cip0001/survey-matrix.csv` exists with theme × file × status columns.
- [ ] All eleven public consumer themes from README are covered.
- [ ] Reproduction command is cited in task notes or CIP-0001 appendix.

## Implementation Notes

Checklist file families from CIP-0001: type layouts (`article`, `inproceedings`,
…), `publication.html`, `paper_authors_abstract_links.html`, `paper_abstract.html`,
`cite-as.html`, `listpaper.html`, `extractinfo_publication.html`, copy sections,
SEO includes, `assets/bib/citeproc.yaml`.

Prefer default-branch GitHub trees over stale local checkouts where they diverge.

## Related

- CIP: 0001
- Deliverable: `cip/cip0001/survey-matrix.csv`

## Progress Updates

### 2026-09-01

Task created from CIP-0001 implementation plan step 1.
