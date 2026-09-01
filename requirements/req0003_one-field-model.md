---
id: "0003"
title: "One Publication Field Model Across Surfaces"
status: "Proposed"
priority: "High"
created: "2026-09-01"
last_updated: "2026-09-01"
related_tenets: ["bibliographic-coherence"]
stakeholders: ["content authors", "readers", "indexing systems"]
tags:
  - citations
  - metadata
  - citeproc
---

# REQ-0003: One Publication Field Model Across Surfaces

## Description

For a given publication page, HTML cite UI, paper SEO/discovery metas, copy-to-clipboard formats (BibTeX, APA, RIS, EndNote), and bibliography export must derive from the same conceptual publication record. Legacy front-matter aliases may exist at the edge, but presentation must not invent parallel bibliographic vocabularies per surface.

**Why this matters**: Implements *Bibliographic Coherence* — one record, many renderings.

**Who benefits**: Authors (consistent metadata), readers (accurate cite/export), search engines and Scholar (aligned metas).

## Acceptance Criteria

- [ ] Venue line, author list, and year on the rendered page agree with copy/export output for the same post
- [ ] Google Scholar / Open Graph / Twitter metas use the same extracted publication fields as on-page presentation
- [ ] Legacy post keys are accepted where they exist today and normalised before rendering
- [ ] External CiteProc tooling can consume a bibliography export consistent with on-site presentation

## Notes

Specific field names (CSL / CiteProc-shaped), extract helpers, and `citeproc.yaml` wiring are HOW — to be designed in CIPs.

## References

- **Related Tenets**: bibliographic-coherence

## Progress Updates

### 2026-09-01
Requirement proposed; absorbs former *CiteProc-Shaped Fields* tenet as WHAT.
