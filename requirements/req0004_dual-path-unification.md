---
id: "0004"
title: "Path-1 and Path-2 Themes Share One Core"
status: "Proposed"
priority: "High"
created: "2026-09-01"
last_updated: "2026-09-01"
related_tenets: ["one-shared-core", "content-not-chrome"]
stakeholders: ["org theme maintainers", "Fenner maintainers"]
tags:
  - architecture
  - unification
---

# REQ-0004: Path-1 and Path-2 Themes Share One Core

## Description

Public consumer themes today use two live page-rendering paths: path-1 (`publication` + `paper_authors_abstract_links`) and path-2 (`default` + `paper_abstract`). Fenner must serve both families from one maintained publication core so they stop drifting as separate forks.

**Why this matters**: *One Shared Publication Core* — the duplication cost is hand-syncing across eleven public themes, not maintaining one canonical stack.

**Who benefits**: All org theme maintainers; Fenner maintainers who fix bugs once.

## Acceptance Criteria

- [ ] Path-1 consumer themes (lawrennd, mlatcl, uk-ai, datatrustsinitiative, acceleratescience) can adopt Fenner without reverting to private citation copies
- [ ] Path-2 consumer themes (aistats, gpschool, mlresearch, mlr-datasets, dalimeeting, rs-delve) can adopt Fenner without maintaining a separate paper-page encoding
- [ ] A single Fenner release addresses cite/SEO/export behaviour for both paths

## Notes

Extraction source, adapters, and migration sequencing are CIP work. This requirement states the convergence outcome.

## References

- **Related Tenets**: one-shared-core, content-not-chrome

## Progress Updates

### 2026-09-01
Requirement proposed during README theme inventory review.
