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

**Description**: Fenner owns scholarly publication presentation — layouts, citation UI, paper SEO, and related includes. Organisation themes own headers, footers, nav, logos, and `site.style` skins. Keeping that boundary sharp stops Fenner from becoming another full theme fork and lets each org brand without forking the citation stack.

**Quote**: *"Fenner presents the paper; the theme presents the site."*

**Examples**:
- Shipping `publication`, `article`, and `cite-as` from Fenner while leaving `default`, `header`, and `footer` in each `jekyll-theme`
- Letting `publication.html` chrome (hero bands, people sidebars) stay theme-local when it is branding, not citation logic
- Documenting in-scope vs out-of-scope paths so installers never overwrite org nav includes

**Counter-examples**:
- Copying Minima `home` / `header` into Fenner “for convenience”
- Encoding org colours or logo markup inside shared paper includes
- Treating Fenner as a drop-in replacement for an entire `jekyll-theme`

**Conflicts**:
- Can conflict with "One Shared Publication Core" when chrome and content are tangled in one file today
- Resolution: Extract the citation/SEO fragments into Fenner; leave the chrome shell in the theme, even if that means a thin theme-local `publication.html` wrapper

**Version**: 1.0 (2026-09-01)
