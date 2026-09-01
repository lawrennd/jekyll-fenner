# CIP-0001 synthesis decisions

Survey date: 2026-09-01. Inputs: `survey-matrix.csv`, `history-notes.md`,
`content-contract-samples.md`.

## 1. Canonical source tree

**lawrennd/jekyll-theme @ `main`** is the canonical source for Fenner-owned
paths. mlatcl is byte-identical on the publication core; nothing newer exists
only on path-2 themes for the shared cite/SEO stack.

## 2. Path-2 adapter strategy

**Option C (adapters)** — adopted.

- Fenner installs `paper_authors_abstract_links.html` as the rich body.
- `paper_abstract.html` remains for path-2 compatibility; refactor to delegate
  to shared extract/render logic without forcing path-2 themes onto
  `layout: publication`.
- Path-2 themes retain theme-local `_layouts/article.html` (`layout: default`)
  until maintainers opt into path-1 wiring; install script must not overwrite
  path-2 `article.html` without an explicit flag.

## 3. Field normalisation boundary

`extractinfo_publication.html` (lawrennd canonical) is the single extract pass.
Legacy aliases documented in `content-contract-samples.md`.

## 4. Chrome split rules

| Asset | Owner |
|-------|-------|
| `publication.html` | Theme-local (uk-ai people sidebar, acceleratescience Foundation hero, …) |
| `default`, `header`, `footer`, nav, hero | Theme-local |
| `_includes/<style>/` skins | Theme-local |
| Body, cite, SEO, extract, citeproc.yaml | Fenner-owned |

## 5. File classification (checklist summary)

| Path | Classification |
|------|----------------|
| `_layouts/publication.html` | theme-local |
| `_layouts/article.html` (path-1) | fenner-owned |
| `_layouts/article.html` (path-2) | theme-local until migration |
| `_includes/paper_authors_abstract_links.html` | fenner-owned |
| `_includes/paper_abstract.html` | fenner-owned (adapter) |
| `_includes/extractinfo_publication.html` | fenner-owned |
| `_includes/copy_sections.html` + entries | fenner-owned |
| `_includes/seo-info.html` + paper metas | fenner-owned |
| `_includes/cite-as.html` | fenner-owned (rs-delve may override locally) |
| `_includes/listpaper.html` | fenner-owned (path-2 drift → install refreshes) |
| `assets/bib/citeproc.yaml` | fenner-owned |

Install manifest: `fenner-owned-paths.txt`.
