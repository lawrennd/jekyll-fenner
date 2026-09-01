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
  - pandoc
  - authoring
---

## Tenet: presentation-not-authoring

**Title**: Presentation, Not Authoring

**Description**: Fenner is Jekyll presentation of already-authored publication pages. Pandoc templates, grant and talk authoring flows, and Markdown-to-paper pipelines belong in packages such as `lamd` and content repos. Mixing authoring and presentation in Fenner would blur ownership and pull unrelated tooling into theme installs.

**Quote**: *"Author elsewhere; present here."*

**Examples**:
- Keeping Pandoc / `_pandoc` templates out of Fenner’s in-scope file list
- Assuming posts already carry CiteProc-shaped front matter when Fenner renders them
- Pointing authors to pandoc for writing workflows and to Fenner for site rendering

**Counter-examples**:
- Adding Pandoc reference docs or grant skeletons to the Fenner gem
- Making Fenner depend on a full authoring toolchain to render a paper page
- Duplicating `lamd` templates “so themes have everything in one place”

**Conflicts**:
- Can conflict with desire for a single scholarly toolkit repo
- Resolution: Compose packages (`lamd` for authoring, Fenner for Jekyll presentation, themes for chrome) rather than collapsing them

**Version**: 1.0 (2026-09-01)
