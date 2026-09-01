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

Publication presentation is currently duplicated across Minima-derived theme
forks and related site trees:

| Consumer | Theme / location | Publication stack today |
|----------|------------------|-------------------------|
| [`lawrennd/publications`](https://github.com/lawrennd/publications), [`lawrennd.github.io`](https://github.com/lawrennd/lawrennd.github.io) | [`lawrennd/jekyll-theme`](https://github.com/lawrennd/jekyll-theme) | Full: `publication` layout, SEO/OG/Twitter/Scholar metas, cite/bib copy UI |
| [`mlatcl/mlatcl.github.io`](https://github.com/mlatcl/mlatcl.github.io) | [`mlatcl/jekyll-theme`](https://github.com/mlatcl/jekyll-theme) | Same stack as lawrennd (near byte-identical publication/SEO includes) |
| PMLR volumes (e.g. [`mlresearch/v16`](https://github.com/mlresearch/v16)) | [`mlresearch/jekyll-theme`](https://github.com/mlresearch/jekyll-theme) | Thinner fork: paper type layouts exist; richer `publication` + paper SEO path is incomplete |
| [`ai-cam/ai-cam.github.io`](https://github.com/ai-cam/ai-cam.github.io) | Site-local layouts (no remote theme) | Different design system; only partial bibliography overlap — **out of scope for v1** |

**Findings that motivate Fenner**

1. Sites mostly point at org themes via `remote_theme`; the publication/SEO
   machinery lives in those themes, not in the content repos.
2. `lawrennd/jekyll-theme` and `mlatcl/jekyll-theme` largely duplicate the same
   publication core; divergence is mostly chrome (`default` / `header` /
   `footer`, `style:`-scoped includes).
3. `mlresearch/jekyll-theme` is a subset of the same Minima lineage and should
   pull the same core rather than drift further.
4. Authoring / Pandoc templates belong elsewhere ([`lamd`](https://github.com/lawrennd/lamd));
   Fenner is Jekyll presentation only.
5. Hand-syncing three theme forks is the real cost. An idempotent install of
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

### Out of scope (remain in org themes or sites)

- Site chrome: `default`, `home`, `header`, `footer`, nav, logos
- Brand skins under `_includes/<style>/` (`pmlr`, `mlatcl`, …)
- ai@cam Bootstrap / CMS layouts (optional later alignment only)
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
with `mlatcl/jekyll-theme`. Layout **names** stay stable so existing posts keep
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
| `*/jekyll-theme` | Org shells + branding; **consume** Fenner |
| [`lamd`](https://github.com/lawrennd/lamd) | Markdown → talks/notes/papers; Pandoc templates — not Fenner |
| [`lynguine`](https://github.com/lawrennd/lynguine) | Data / Liquid orchestration — not presentation |
| Upstream [Minima](https://github.com/jekyll/minima) | Historical base of the theme forks; Fenner is not a Minima replacement |
| Upstream CiteProc / CSL | Conceptual model for citation presentation (Fenner’s advocacy and tooling) |

## Status

Bootstrap only: repository scaffolding and documentation. No layouts have been
copied yet; first extract + install script come next.

## Licence

MIT — see [LICENSE.txt](LICENSE.txt).
