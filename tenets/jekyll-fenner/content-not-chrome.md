---
id: "content-not-chrome"
title: "Content Layer, Not Site Chrome"
status: "Active"
created: "2026-09-01"
last_reviewed: "2026-09-01"
review_frequency: "Annual"
conflicts_with: ["one-shared-core"]
tags:
  - architecture
  - scope
  - themes
---

## Tenet: content-not-chrome

**Title**: Content Layer, Not Site Chrome

**Description**: Scholarly publication presentation and site identity are different responsibilities. When they are bundled in one fork, every branding change risks breaking citation logic, and every citation fix risks breaking org chrome. Fenner exists because that coupling is the main reason the ecosystem drifts.

**Quote**: *"Fenner presents the paper; the theme presents the site."*

**Examples**:
- An org changes nav and hero styling without touching how papers cite or export
- A citation bug is fixed once and propagates to every consumer without re-merging headers
- New conference branding does not require forking the publication stack

**Counter-examples**:
- Treating Fenner as a full site theme replacement
- Fixing cite UI in one org fork while siblings keep divergent copies “because the header is different”
- Letting branding markup drive bibliographic field choices

**Conflicts**:
- Can conflict with "One Shared Publication Core" when historical files mix presentation and chrome
- Resolution: Unify the citation core; accept that chrome may stay theme-local until extracted

**Version**: 1.1 (2026-09-01)
