# jekyll-fenner

Shared Jekyll **publication and citation templates**: layouts and includes for
scholarly pages, cite-as UI, and paper SEO metadata. Named in honour of
[Martin Fenner](https://orcid.org/0000-0003-1419-2405), whose writing on
CiteProc / CSL-oriented citation presentation shaped the layout model this
package extracts and maintains.

This repository is **not** a full site theme. Org chrome (headers, footers,
branding, `site.style` skins) stays in each organisation’s `jekyll-theme`.
Fenner is the shared **content layer** those themes should consume.

## Why this exists

Publication and CiteProc-oriented presentation is duplicated across public
Minima-derived theme forks. Every theme below is **public on GitHub** and
renders CiteProc / CSL-shaped publication data in at least one of the ways
listed next. (Private forks and themes with no citation stack are omitted.)

### How public themes render CiteProc

Two live page-rendering paths appear in the wild. Both also ship
`assets/bib/citeproc.yaml`, which emits a CSL-YAML bibliography from site
posts for external CiteProc tooling.

#### 1. `publication` layout path (rich stack)

Type layouts (`article`, `inproceedings`, `techreport`, …) set
`layout: publication`. The publication page body comes from
`paper_authors_abstract_links` (authors, venue line from CSL-like fields,
abstract, links, BibTeX / APA / EndNote / RIS copy UI). Paper SEO metas
(`seo-info`, Google Scholar / Open Graph / Twitter) sit in the head includes.

| Theme | Notes |
|-------|--------|
| [`lawrennd/jekyll-theme`](https://github.com/lawrennd/jekyll-theme) | Canonical rich stack; used by [`lawrennd/publications`](https://github.com/lawrennd/publications) and [`lawrennd.github.io`](https://github.com/lawrennd/lawrennd.github.io) |
| [`mlatcl/jekyll-theme`](https://github.com/mlatcl/jekyll-theme) | Near byte-identical publication/SEO includes to lawrennd; used by [`mlatcl/mlatcl.github.io`](https://github.com/mlatcl/mlatcl.github.io) |
| [`uk-ai/jekyll-theme`](https://github.com/uk-ai/jekyll-theme) | Same article → publication → `paper_authors_abstract_links` path; `publication.html` chrome adds author people linking |
| [`datatrustsinitiative/jekyll-theme`](https://github.com/datatrustsinitiative/jekyll-theme) | Same pattern as uk-ai |
| [`acceleratescience/jekyll-theme`](https://github.com/acceleratescience/jekyll-theme) | Same article path; Foundation-style `publication.html` chrome |

#### 2. Legacy `default` + `paper_abstract` path

No `publication.html`. Type layouts set `layout: default` and include
`paper_abstract`, which inlines the venue line, abstract, “Cite this Paper”
block, and `copy_sections` (BibTeX / APA / EndNote / RIS). SEO and
`cite-as` (for report-style pages) are still present; `citeproc.yaml` is
present as in path 1.

| Theme | Notes |
|-------|--------|
| [`aistats/jekyll-theme`](https://github.com/aistats/jekyll-theme) | Legacy paper page body via `paper_abstract` |
| [`gpschool/jekyll-theme`](https://github.com/gpschool/jekyll-theme) | Same legacy path as aistats |
| [`mlresearch/jekyll-theme`](https://github.com/mlresearch/jekyll-theme) | Same legacy path on GitHub; used by PMLR volume sites (e.g. [`mlresearch/v16`](https://github.com/mlresearch/v16)) |
| [`mlr-datasets/jekyll-theme`](https://github.com/mlr-datasets/jekyll-theme) | Same legacy path as aistats |
| [`dalimeeting/jekyll-theme`](https://github.com/dalimeeting/jekyll-theme) | Same legacy path on GitHub |
| [`rs-delve/jekyll-theme`](https://github.com/rs-delve/jekyll-theme) | Same legacy path; `cite-as` tuned for DELVE report / addendum layouts |

**Findings that motivate Fenner**

1. Sites mostly point at org themes via `remote_theme`; the publication/SEO
   machinery lives in those themes, not in the content repos.
2. Path-1 themes share one publication core; divergence is mostly chrome
   (`default` / `header` / `footer`, `publication.html` shell, `style:`-scoped
   includes).
3. Path-2 themes are an earlier encoding of the same CiteProc field model
   (`issued`, `container-title`, `DOI`, …) inside `paper_abstract` rather than
   behind a `publication` layout — Fenner should absorb both encodings into
   one maintained stack.
4. Authoring / Pandoc templates belong elsewhere ([`lamd`](https://github.com/lawrennd/lamd));
   Fenner is Jekyll presentation only.
5. Hand-syncing many theme forks is the real cost. An idempotent install of
   Fenner into each theme (or a thin gem consumed by each theme) replaces that.

## Scope

### In scope (extract / own here)

- Layouts: `publication` and type aliases used by content
  (`article`, `inproceedings`, `techreport`, … as wired today)
- Includes for listing and page body:
  `listpaper`, `listauthors`, `paper_abstract`,
  `paper_authors_abstract_links`, …
- SEO / discovery: `seo-info`, `paper_open_graph_meta`,
  `paper_twitter_meta`, `paper_google_scholar`, …
- Cite / export UI: `cite-as`, BibTeX / APA / EndNote / RIS entry + copy
  sections, `extractinfo_publication`, …
- CSL export helper: `assets/bib/citeproc.yaml` (where themes still need it
  vendored)

### Out of scope (remain in org themes or sites)

- Site chrome: `default`, `home`, `header`, `footer`, nav, logos
- Brand skins under `_includes/<style>/` (`pmlr`, `mlatcl`, …)
- Pandoc / grant / talk authoring templates (`lamd`, `publications` `_pandoc`)

## Planned layout

```
jekyll-fenner/
├── README.md
├── LICENSE.txt
├── jekyll-fenner.gemspec          # optional Jekyll include/theme gem
├── script/
│   └── install                    # idempotent install into a target theme
├── _layouts/                      # publication + type alias layouts
└── _includes/                     # seo, cite, list*, paper_* fragments
```

Exact file lists will be filled by extracting the shared core from
`lawrennd/jekyll-theme` (canonical source for the rich stack) and reconciling
with the other path-1 themes, then mapping path-2 `paper_abstract` consumers
onto the same layouts. Layout **names** stay stable so existing posts keep
`layout: article` / `inproceedings` / etc.

## Distribution

Goal: **idempotent reinstall** across theme repos.

Intended flow (to be implemented in `script/install`):

```bash
# from a theme checkout, e.g. ~/lawrennd/jekyll-theme
../jekyll-fenner/script/install .
# or
FENNER_ROOT=~/lawrennd/jekyll-fenner ./script/install /path/to/jekyll-theme
```

The installer should:

1. Copy (or symlink, where appropriate) Fenner `_layouts` / `_includes` into
   the target theme without touching chrome files.
2. Be safe to re-run: overwrite only Fenner-owned paths; leave org overrides alone.
3. Optionally record installed revision (commit SHA) for audit.

Longer term, packaging as a Ruby gem (`jekyll-fenner`) that org themes depend
on may replace copy-install for repos that can use Bundler (GitHub Pages
`remote_theme` consumers may still need the install step or vendoring).

## Relationship to other packages

| Package | Role vs Fenner |
|---------|----------------|
| `*/jekyll-theme` (public CiteProc consumers above) | Org shells + branding; **consume** Fenner |
| [`lamd`](https://github.com/lawrennd/lamd) | Markdown → talks/notes/papers; Pandoc templates — not Fenner |
| [`lynguine`](https://github.com/lawrennd/lynguine) | Data / Liquid orchestration — not presentation |
| Upstream [Minima](https://github.com/jekyll/minima) | Historical base of the theme forks; Fenner is not a Minima replacement |
| Upstream CiteProc / CSL | Conceptual model for citation presentation (Fenner’s advocacy and tooling) |

## Status

Bootstrap only: repository scaffolding and documentation. No layouts have been
copied yet; first extract + install script come next.

## Licence

MIT — see [LICENSE.txt](LICENSE.txt).
