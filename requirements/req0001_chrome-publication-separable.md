---
id: "0001"
title: "Chrome and Publication Presentation Are Separable"
status: "Proposed"
priority: "High"
created: "2026-09-01"
last_updated: "2026-09-01"
related_tenets: ["content-not-chrome", "one-shared-core"]
stakeholders: ["org theme maintainers", "content repo authors"]
tags:
  - scope
  - themes
  - chrome
---

# REQ-0001: Chrome and Publication Presentation Are Separable

> **Remember**: Requirements describe **WHAT** should be true (outcomes), not HOW to achieve it.

## Description

Organisation themes must be able to adopt Fenner for scholarly publication pages while retaining their own site chrome — headers, footers, navigation, branding, and style skins. Fenner-owned presentation must not require replacing or forking an entire `jekyll-theme`.

**Why this matters**: Aligns with *Content Layer, Not Site Chrome* and *One Shared Publication Core* — citation logic is shared; identity stays local.

**Who benefits**: Theme maintainers who need org branding without maintaining a private citation fork; content authors whose posts work across themes.

## Acceptance Criteria

- [ ] A theme can install Fenner publication/citation assets without losing or overwriting org-owned chrome files
- [ ] Publication pages render correctly when theme chrome differs from the canonical lawrennd stack
- [ ] In-scope vs out-of-scope paths for Fenner are documented so installers know what is Fenner-owned vs theme-owned

## Notes

Concrete file lists and installer behaviour belong in CIPs. This requirement states the separability outcome only.

## References

- **Related Tenets**: content-not-chrome, one-shared-core

## Progress Updates

### 2026-09-01
Requirement proposed during tenet/requirements hierarchy review.
