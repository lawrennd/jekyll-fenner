---
id: "presentation-not-authoring"
title: "Presentation, Not Authoring"
status: "Active"
created: "2026-09-01"
last_reviewed: "2026-09-01"
review_frequency: "Annual"
conflicts_with: []
tags:
  - scope
  - authoring
---

## Tenet: presentation-not-authoring

**Title**: Presentation, Not Authoring

**Description**: Fenner renders already-authored publication pages in Jekyll. Authoring pipelines — Pandoc templates, grant skeletons, talk workflows — belong elsewhere. Mixing them into Fenner blurs ownership and pulls unrelated tooling into every theme install.

**Quote**: *"Author elsewhere; present here."*

**Examples**:
- Authors write in `lamd` or content repos; sites render through Fenner-backed themes
- Theme installs stay lightweight because they do not ship a full authoring toolchain
- Presentation fixes do not require republishing author source files

**Counter-examples**:
- Adding Pandoc reference docs to the Fenner gem “for convenience”
- Making Fenner depend on an authoring stack just to render a paper page
- Duplicating authoring templates inside Fenner so “themes have everything”

**Conflicts**:
- Can conflict with desire for a single scholarly toolkit repo
- Resolution: Compose packages (authoring, presentation, chrome) rather than collapsing them

**Version**: 1.1 (2026-09-01)
