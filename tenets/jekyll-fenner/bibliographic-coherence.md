---
id: "bibliographic-coherence"
title: "Bibliographic Coherence"
status: "Active"
created: "2026-09-01"
last_reviewed: "2026-09-01"
review_frequency: "Annual"
conflicts_with: []
tags:
  - citations
  - metadata
  - citeproc
---

## Tenet: bibliographic-coherence

**Title**: Bibliographic Coherence

**Description**: A publication is one conceptual record, not a set of unrelated strings for HTML, SEO, copy buttons, and exports. When those surfaces invent parallel vocabularies, authors and maintainers pay twice: once at write time and again at every theme fork. Fenner’s role is to keep many renderings faithful to one bibliographic idea.

**Quote**: *"One record; many renderings."*

**Examples**:
- Venue line, cite block, and Scholar metas disagreeing on year or container is treated as a defect, not a theme quirk
- Export formats (BibTeX, APA, RIS) reflect the same author list the page shows
- Legacy post keys are tolerated at the edge but normalised before presentation

**Counter-examples**:
- Hard-coded citation strings that ignore available DOI or issued date
- Theme-specific aliases for the same fact with no mapping to a shared model
- SEO metas that invent titles or authors instead of reusing the publication record

**Conflicts**:
- Can conflict with consumer continuity when old posts use idiosyncratic keys
- Resolution: Normalise internally; do not force bulk content rewrites for presentation alone

**Version**: 1.0 (2026-09-01)
