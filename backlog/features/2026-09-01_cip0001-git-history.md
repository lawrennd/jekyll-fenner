---
id: "2026-09-01_cip0001-git-history"
title: "CIP-0001: Git history pass on publication file families"
status: "Ready"
priority: "Medium"
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

# Task: Git history pass on publication file families (CIP-0001 phase B)

## Description

For file families that differ across themes or define path-1 vs path-2, run
targeted `git log --follow` on representative theme checkouts. Produce a short
narrative of when cores diverged, not a full blame dump.

## Acceptance Criteria

- [ ] `cip/cip0001/history-notes.md` documents history for each focus family.
- [ ] Notes cover: `paper_authors_abstract_links` vs `paper_abstract` introduction,
      `publication.html` chrome divergence, copy_sections / citeproc.yaml timeline,
      lawrennd vs mlatcl drift status.
- [ ] Each narrative cites at least one reproducible git command.

## Implementation Notes

Focus files (from CIP-0001): `article.html`, `paper_abstract.html`,
`paper_authors_abstract_links.html`, `publication.html`, `seo-info.html`,
`extractinfo_publication.html`.

Can run in parallel with snapshot inventory; cross-reference matrix once available.

## Related

- CIP: 0001
- Deliverable: `cip/cip0001/history-notes.md`

## Progress Updates

### 2026-09-01

Task created from CIP-0001 implementation plan step 2.
