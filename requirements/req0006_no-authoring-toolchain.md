---
id: "0006"
title: "Fenner Excludes Authoring Toolchains"
status: "Proposed"
priority: "Medium"
created: "2026-09-01"
last_updated: "2026-09-01"
related_tenets: ["presentation-not-authoring"]
stakeholders: ["Fenner maintainers", "lamd maintainers", "content authors"]
tags:
  - scope
  - authoring
---

# REQ-0006: Fenner Excludes Authoring Toolchains

## Description

Fenner’s deliverable set must not include Pandoc templates, grant skeletons, talk authoring flows, or other Markdown-to-paper pipelines. Rendering assumes posts already carry suitable front matter; authoring remains in packages such as `lamd` and content repos.

**Why this matters**: *Presentation, Not Authoring* — scope creep into authoring would bloat every theme install and duplicate `lamd`.

**Who benefits**: Fenner maintainers (focused scope); theme installers (lighter dependency surface); authoring tool maintainers (clear ownership).

## Acceptance Criteria

- [ ] Fenner in-scope file list excludes Pandoc / `_pandoc` and grant/talk authoring templates
- [ ] A theme can render publication pages without installing an authoring toolchain
- [ ] Documentation points authors to authoring packages for write workflows and to Fenner for Jekyll presentation

## Notes

Cross-links to `lamd` in README are fine; bundling authoring assets in Fenner is out of scope.

## References

- **Related Tenets**: presentation-not-authoring

## Progress Updates

### 2026-09-01
Requirement proposed during tenet/requirements hierarchy review.
