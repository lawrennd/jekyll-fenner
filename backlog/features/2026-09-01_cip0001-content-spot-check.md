---
id: "2026-09-01_cip0001-content-spot-check"
title: "CIP-0001: Live content repo layout contract spot-check"
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

# Task: Live content repo layout contract spot-check (CIP-0001 phase C)

## Description

Sample real publication posts from path-1 and path-2 content repos to confirm
which layout names and front-matter keys appear in the wild. Validates REQ-0002
stable layout contracts against live content, not theme templates alone.

## Acceptance Criteria

- [ ] At least one path-1 content repo sampled (e.g. `lawrennd/publications`).
- [ ] At least one path-2 content repo sampled (e.g. `mlresearch/v16`).
- [ ] `cip/cip0001/content-contract-samples.md` lists exemplar front matter per
      layout type with source post references.
- [ ] Documented legacy alias keys that themes must continue accepting.

## Implementation Notes

Trace `layout:` values and CSL-shaped fields (`issued`, `container-title`, DOI,
author given/family) in sampled posts. Note any theme-specific aliases for
normalisation in `extractinfo_publication.html`.

## Related

- CIP: 0001
- Requirements: 0002, 0003
- Deliverable: `cip/cip0001/content-contract-samples.md`

## Progress Updates

### 2026-09-01

Task created from CIP-0001 implementation plan step 3.
