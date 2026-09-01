---
id: "0002"
title: "Existing Layout Names Keep Working"
status: "Proposed"
priority: "High"
created: "2026-09-01"
last_updated: "2026-09-01"
related_tenets: ["one-shared-core", "content-not-chrome"]
stakeholders: ["content repo authors", "theme maintainers"]
tags:
  - compatibility
  - layouts
---

# REQ-0002: Existing Layout Names Keep Working

## Description

Content repos already declare publication types with layout names such as `article`, `inproceedings`, and `techreport`. After Fenner adoption, those posts must continue to render without bulk-editing front matter or renaming layouts.

**Why this matters**: Consumer continuity is a precondition for unifying the citation core. Refactors must happen behind stable layout contracts, not by forcing content migrations.

**Who benefits**: Authors and maintainers of live publication corpora across lawrennd, mlatcl, PMLR, and sibling sites.

## Acceptance Criteria

- [ ] Posts with existing type layouts render after Fenner is installed into a consumer theme
- [ ] Public include names used by live sites (e.g. `listpaper`, `cite-as`, `seo-info`) remain usable unless an explicit, versioned migration is planned
- [ ] No requirement for content repos to rename `layout:` values as part of Fenner adoption

## Notes

How path-1 and path-2 encodings are unified behind those layout names is a CIP concern.

## References

- **Related Tenets**: one-shared-core, content-not-chrome

## Progress Updates

### 2026-09-01
Requirement proposed; absorbs former *Stable Layout Contracts* tenet as WHAT.
