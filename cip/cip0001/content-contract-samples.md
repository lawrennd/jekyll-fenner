# CIP-0001: Live content contract samples

Survey date: 2026-09-01. Samples from public content repos on GitHub default
branches.

## Path-1: `lawrennd/publications` (`gh-pages`)

**Source post:** `_posts/1998-01-01-bishop-mixtures97.md`  
**Fetch:** `gh api repos/lawrennd/publications/contents/_posts/1998-01-01-bishop-mixtures97.md?ref=gh-pages`

### Layout contract

```yaml
layout: inproceedings
```

Type layout name matches theme `_layouts/inproceedings.html` → `layout: publication`
(path-1 wiring).

### Front-matter fields observed

| Field | Example | Notes |
|-------|---------|-------|
| `title` | Approximating Posterior Distributions… | Page title |
| `abstract` | \| block scalar | Body abstract |
| `author` | list of `{family, given, institute, url, …}` | Rich author cards |
| `booktitle` | Advances in Neural Information Processing Systems | Venue (legacy alias) |
| `volume` | `'10'` | Container volume |
| `categories` | `[Bishop:mixtures97]` | Internal keys |
| `crossref` | Jordan:nips97 | Proceedings cross-ref |
| `editor` | list of author-shaped dicts | Proceedings editors |
| `errata` | `[]` | Optional |
| `extras` | mapping | Optional site-specific |

Legacy aliases (`booktitle`, `date`) coexist with CSL-shaped fields on newer
posts. Fenner normalisation (`extractinfo_publication.html`) must accept both
(REQ-0003).

### Newer path-1 posts

Recent `_posts/*.md` files (e.g. 2024–2026) add `issued`, `DOI`,
`container-title`, and `layout: article` on preprints — same layout-name
contract, richer CSL fields.

---

## Path-2: `mlresearch/v16` (`gh-pages`)

**Source post:** `_posts/2011-04-21-bodo11a.md`  
**Fetch:** `https://raw.githubusercontent.com/mlresearch/v16/gh-pages/_posts/2011-04-21-bodo11a.md`

### Layout contract

```yaml
layout: inproceedings
```

Same public layout name as path-1. Theme resolves via path-2 wiring:
`inproceedings.html` → `layout: default` + `paper_abstract.html`.

### Front-matter fields observed

| Field | Example | Notes |
|-------|---------|-------|
| `title` | Active Learning with Clustering | |
| `abstract` | block scalar | |
| `layout` | inproceedings | Stable contract name (REQ-0002) |
| `series` | Proceedings of Machine Learning Research | PMLR-specific |
| `id` | bodo11a | Volume paper id |
| `author` | `{given, family}` list | CSL-shaped |
| `container-title` | Active Learning and Experimental Design workshop… | |
| `volume` | `'16'` | |
| `issued` | `date-parts: [[2011, 4, 21]]` | CSL date |
| `publisher` | PMLR | |
| `genre` | inproceedings | |
| `pdf` | proceedings.mlr.press URL | |
| `firstpage`, `lastpage`, `page`, `order` | pagination helpers | PMLR volume convention |
| `date` | 2011-04-21 | Legacy alias alongside `issued` |
| `address` | Sardinia, Italy | |

Comment in file references CiteProc YAML format — confirms path-2 pages use the
same bibliographic model behind `paper_abstract`.

---

## Contract summary

| Contract element | Path-1 content | Path-2 content |
|------------------|----------------|----------------|
| Public layout names | `article`, `inproceedings`, … | Same names |
| Theme wiring | → `publication` layout | → `default` + `paper_abstract` |
| Author shape | `{family, given, …}` | `{given, family}` |
| Venue | `booktitle` and/or `container-title` | `container-title`, `series` |
| Date | `date`, `issued` | `date`, `issued` |
| Export fields | DOI, pdf, volume | pdf, volume, pagination ids |

**REQ-0002 satisfied:** Content repos do not need renames when Fenner unifies
the stack. **REQ-0004:** Unification happens in includes/adapters, not post
front matter.

## Legacy aliases to preserve at the edge (REQ-0003)

- `booktitle` → container title
- `date` → issued date when `issued` absent
- `author` with `institute` / `url` extras (path-1 people linking)
- PMLR pagination keys (`firstpage`, `lastpage`, `page`, `order`, `id`)

Normalisation boundary: `extractinfo_publication.html` (Fenner-owned).
