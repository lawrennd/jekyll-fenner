---
id: "stable-layout-contracts"
title: "Stable Layout Contracts"
status: "Active"
created: "2026-09-01"
last_reviewed: "2026-09-01"
review_frequency: "Annual"
conflicts_with: ["one-shared-core"]
tags:
  - compatibility
  - layouts
  - migration
---

## Tenet: stable-layout-contracts

**Title**: Stable Layout Contracts

**Description**: Content repos already declare `layout: article`, `inproceedings`, `techreport`, and related types. Fenner must keep those layout names and their expected includes working so themes can adopt the shared core without rewriting every post. Refactors happen behind the contract, not by renaming the public surface.

**Quote**: *"Posts keep their layouts; Fenner absorbs the drift."*

**Examples**:
- Preserving type-alias layouts that only choose the publication body path
- Mapping legacy `paper_abstract` consumers onto the richer publication stack without renaming layouts
- Treating include names used by live sites (`listpaper`, `cite-as`, `seo-info`) as part of the public contract unless a CIP plans a migration

**Counter-examples**:
- Renaming `article` to `fenner-article` and forcing content repos to bulk-edit
- Removing `cite-as` because reports are “out of fashion” without a migration path
- Changing include parameters in ways that break existing `{% include %}` call sites

**Conflicts**:
- Can conflict with "One Shared Publication Core" when unifying path-1 and path-2 wants cleaner names
- Resolution: Prefer internal consolidation and adapters; rename only with an explicit, versioned migration CIP

**Version**: 1.0 (2026-09-01)
