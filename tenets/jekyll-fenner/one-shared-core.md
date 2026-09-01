---
id: "one-shared-core"
title: "One Shared Publication Core"
status: "Active"
created: "2026-09-01"
last_reviewed: "2026-09-01"
review_frequency: "Annual"
conflicts_with: ["content-not-chrome", "stable-layout-contracts"]
tags:
  - architecture
  - duplication
  - maintenance
---

## Tenet: one-shared-core

**Title**: One Shared Publication Core

**Description**: The cost of today’s ecosystem is hand-syncing CiteProc presentation across many Minima-derived forks. Fenner exists so path-1 (`publication` + `paper_authors_abstract_links`) and path-2 (`default` + `paper_abstract`) converge on one maintained stack. Themes consume that core; they do not each keep a private fork of citation logic.

**Quote**: *"Fork chrome freely; share the citation core."*

**Examples**:
- Extracting the rich stack from `lawrennd/jekyll-theme` as the canonical Fenner source, then reconciling other path-1 themes against it
- Absorbing legacy `paper_abstract` behaviour so path-2 themes can install Fenner instead of drifting further
- Fixing a BibTeX copy bug once in Fenner and reinstalling into every consumer theme

**Counter-examples**:
- Patching `cite-as` only in `mlatcl/jekyll-theme` and leaving siblings stale
- Adding a third parallel encoding of paper pages “just for this conference”
- Treating Fenner as optional documentation while themes keep divergent copies as the real source of truth

**Conflicts**:
- Can conflict with "Content Layer, Not Site Chrome" when historical files mix both
- Resolution: Split files at extract time; chrome stays theme-local
- Can conflict with "Stable Layout Contracts" during unification
- Resolution: Preserve layout names; unify implementation underneath

**Version**: 1.0 (2026-09-01)
