---
id: "2026-09-01_cip0001-synthesis-manifest"
title: "CIP-0001: Synthesis workshop and Fenner path manifest"
status: "Proposed"
priority: "High"
created: "2026-09-01"
last_updated: "2026-09-01"
category: "features"
related_cips: ["0001"]
owner: "Neil Lawrence"
dependencies:
  - "2026-09-01_cip0001-snapshot-inventory"
  - "2026-09-01_cip0001-git-history"
  - "2026-09-01_cip0001-content-spot-check"
tags:
  - backlog
  - survey
  - cip0001
---

# Task: Synthesis workshop and Fenner path manifest (CIP-0001 phase D)

## Description

Synthesise survey, history, and content spot-check outputs into design decisions
CIP-0001 must close with: canonical source tree, Fenner-owned path manifest,
path-2 adapter strategy (A/B/C), field normalisation boundary, and chrome split
rules.

## Acceptance Criteria

- [ ] Each surveyed file classified: Fenner-owned / theme-local / adapter /
      deprecated.
- [ ] Path-2 unification option (A, B, or C) chosen with rationale (C with
      adapters is the CIP recommendation to evaluate).
- [ ] `cip/cip0001/fenner-owned-paths.txt` written and reviewed — definitive
      install manifest for CIP-0002.
- [ ] Design decisions recorded in CIP-0001 Detailed Description or appendix.

## Implementation Notes

Block until snapshot matrix, history notes, and content samples exist. Manifest
must exclude chrome-only diffs in theme-local `publication.html` wrappers per
REQ-0001.

## Related

- CIP: 0001, 0002 (downstream consumer of manifest)
- Deliverable: `cip/cip0001/fenner-owned-paths.txt`

## Progress Updates

### 2026-09-01

Task created from CIP-0001 implementation plan step 4.
