---
id: "one-shared-core"
title: "One Shared Publication Core"
status: "Active"
created: "2026-09-01"
last_reviewed: "2026-09-01"
review_frequency: "Annual"
conflicts_with: ["content-not-chrome"]
tags:
  - architecture
  - duplication
  - maintenance
---

## Tenet: one-shared-core

**Title**: One Shared Publication Core

**Description**: Hand-syncing citation presentation across many Minima-derived theme forks does not scale. The cost is not the first copy; it is the second, third, and nth patch that never quite match. Fenner exists so org themes fork chrome freely but do not each maintain a private citation stack.

**Quote**: *"Fork chrome freely; share the citation core."*

**Examples**:
- A BibTeX copy bug is fixed once and every consumer theme can pick it up
- Path-1 and path-2 encodings of paper pages converge instead of drifting further apart
- New org themes adopt Fenner rather than cloning an older fork wholesale

**Counter-examples**:
- Patching cite UI in one theme and leaving siblings stale
- Adding a third parallel paper-page encoding “just for this conference”
- Treating Fenner as documentation while divergent theme copies remain the real source of truth

**Conflicts**:
- Can conflict with "Content Layer, Not Site Chrome" when extraction is hard
- Resolution: Share citation logic first; split chrome at the boundary that minimises breakage

**Version**: 1.1 (2026-09-01)
