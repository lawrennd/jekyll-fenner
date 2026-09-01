---
id: "citeproc-shaped-fields"
title: "CiteProc-Shaped Publication Fields"
status: "Active"
created: "2026-09-01"
last_reviewed: "2026-09-01"
review_frequency: "Annual"
conflicts_with: []
tags:
  - citations
  - citeproc
  - csl
  - metadata
---

## Tenet: citeproc-shaped-fields

**Title**: CiteProc-Shaped Publication Fields

**Description**: Publication pages and exports should read CSL / CiteProc-shaped metadata (`issued`, `container-title`, `DOI`, author given/family, and kin) rather than inventing a parallel vocabulary. Fenner’s presentation model follows that field shape so HTML cite UI, SEO metas, copy formats, and `citeproc.yaml` stay aligned with the same conceptual record.

**Quote**: *"One field model; many renderings."*

**Examples**:
- Venue lines and “Cite this Paper” blocks deriving year and container from CSL-like front matter
- Google Scholar / Open Graph metas populated from the same extracted publication fields
- `assets/bib/citeproc.yaml` emitting CSL-YAML from posts for external CiteProc tooling
- BibTeX / APA / RIS / EndNote copy sections sharing one `extractinfo_publication` pass

**Counter-examples**:
- Introducing theme-specific aliases for the same bibliographic facts without mapping them to the shared field model
- Hard-coding citation strings that ignore `issued.date-parts` or DOI when those fields exist
- SEO metas that invent titles or authors instead of reusing the publication extract

**Conflicts**:
- Can conflict with "Stable Layout Contracts" when legacy posts use idiosyncratic keys
- Resolution: Accept legacy aliases in extract helpers, normalise to CiteProc-shaped names internally, keep layout names unchanged

**Version**: 1.0 (2026-09-01)
