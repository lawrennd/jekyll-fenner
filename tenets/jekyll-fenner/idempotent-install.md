---
id: "idempotent-install"
title: "Idempotent Theme Install"
status: "Active"
created: "2026-09-01"
last_reviewed: "2026-09-01"
review_frequency: "Annual"
conflicts_with: []
tags:
  - distribution
  - install
  - operations
---

## Tenet: idempotent-install

**Title**: Idempotent Theme Install

**Description**: Distributing Fenner into organisation themes must be safe to re-run. Install overwrites only Fenner-owned paths, leaves org chrome and overrides alone, and ideally records the installed revision for audit. Every install is a reinstall: themes should be able to pull Fenner updates without manual file archaeology.

**Quote**: *"Re-run the install; do not hand-merge the core."*

**Examples**:
- `script/install` copying Fenner `_layouts` / `_includes` into a theme checkout without touching `header.html`
- Re-running install after a Fenner release and getting a deterministic result
- Recording the Fenner commit SHA somewhere themes can inspect

**Counter-examples**:
- One-shot copy instructions that require humans to resolve conflicts by eye
- Installers that replace the entire theme tree
- Documenting “merge these thirty files” as the upgrade path

**Conflicts**:
- Can conflict with theme-local patches to Fenner-owned files
- Resolution: Prefer upstreaming shared fixes into Fenner; keep genuine org behaviour in clearly non-Fenner paths or documented override hooks

**Version**: 1.0 (2026-09-01)
