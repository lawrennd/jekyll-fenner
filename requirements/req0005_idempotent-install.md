---
id: "0005"
title: "Idempotent Fenner Install Into Themes"
status: "Proposed"
priority: "High"
created: "2026-09-01"
last_updated: "2026-09-01"
related_tenets: ["one-shared-core", "content-not-chrome"]
stakeholders: ["org theme maintainers", "Fenner maintainers"]
tags:
  - distribution
  - install
---

# REQ-0005: Idempotent Fenner Install Into Themes

## Description

Installing or upgrading Fenner in an organisation theme checkout must be safe to re-run. Fenner-owned paths update deterministically; org chrome and documented overrides remain untouched. Theme maintainers must not hand-merge dozens of files to pick up a Fenner fix.

**Why this matters**: Without idempotent install, *One Shared Publication Core* collapses back into manual fork sync.

**Who benefits**: Theme maintainers upgrading after Fenner releases; Fenner maintainers shipping fixes with confidence.

## Acceptance Criteria

- [ ] Re-running install on an already Fenner-enabled theme produces a predictable result (no unintended chrome overwrites)
- [ ] Fenner-owned paths are identifiable before install
- [ ] An installed Fenner revision is inspectable in the theme (e.g. recorded commit SHA or equivalent audit trail)
- [ ] Upgrade path does not require manual three-way merges across the full theme tree

## Notes

Copy-install vs gem packaging, owned-path manifests, and installer script design are CIP work. Former *Idempotent Theme Install* tenet content lives here as WHAT.

## References

- **Related Tenets**: one-shared-core, content-not-chrome

## Progress Updates

### 2026-09-01
Requirement proposed; absorbs former *Idempotent Theme Install* tenet as WHAT.
