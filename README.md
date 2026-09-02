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

Survey-backed manifest (CIP-0001, 2026-09-01). Full install list:
[`cip/cip0001/fenner-owned-paths.txt`](cip/cip0001/fenner-owned-paths.txt).
Reproduce the theme comparison: `python3 scripts/survey_theme_inventory.py`
→ [`cip/cip0001/survey-matrix.csv`](cip/cip0001/survey-matrix.csv).

### In scope (Fenner-owned; installed from `lawrennd/jekyll-theme`)

**Type layouts** (path-1 wiring): `article`, `inproceedings`, `techreport`,
`incollection`, `report`, `addendum`, `dataset`, `data-software`.

**Body includes:** `paper_authors_abstract_links` (canonical rich body),
`paper_abstract` (path-2 adapter).

**Field extract:** `extractinfo_publication`, `extractname`.

**Listing:** `listpaper`, `listauthors`.

**Cite / export UI:** `cite-as`, `copy_sections`, `copy_buttons`,
`hidden_copy_code`, BibTeX / APA / EndNote / RIS `*_entry` and
`*_copy_section` includes.

**SEO / discovery:** `seo-info`, `paper_google_scholar`, `paper_open_graph_meta`,
`paper_twitter_meta`.

**Bibliography export:** `assets/bib/citeproc.yaml`.

Path-2 themes keep theme-local `_layouts/article.html` (`layout: default`) until
they opt into path-1 wiring; Fenner does not rename public layout names (see
[`cip/cip0001/synthesis-decisions.md`](cip/cip0001/synthesis-decisions.md)).

### Out of scope (remain in org themes)

- **`publication.html`** — path-1 chrome differs per org (uk-ai people sidebar,
  acceleratescience Foundation hero, …)
- Site chrome: `default`, `home`, `header`, `footer`, nav, logos
- Brand skins under `_includes/<style>/` (`pmlr`, `mlatcl`, `delve`, …)
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

Exact file lists come from the CIP-0001 manifest at
[`cip/cip0001/fenner-owned-paths.txt`](cip/cip0001/fenner-owned-paths.txt).
Layout **names** stay stable so existing posts keep `layout: article` /
`inproceedings` / etc.

## Distribution

Install Fenner-owned paths from [`cip/cip0001/fenner-owned-paths.txt`](cip/cip0001/fenner-owned-paths.txt) into an org theme checkout:

```bash
# from a theme checkout, e.g. ~/mlatcl/jekyll-theme
../jekyll-fenner/script/install .
# or
FENNER_ROOT=~/lawrennd/jekyll-fenner ./script/install /path/to/jekyll-theme
```

**Flags:** `--dry-run`, `--symlink` (local dev), `--path1-layouts` (overwrite type
layouts on path-2 themes), `--verbose`, `--warn-only`.

The installer:

1. Copies only manifest paths; never touches `header.html`, `publication.html`
   chrome, or `_includes/<style>/` skins.
2. Is safe to re-run: identical files are no-ops; changed Fenner files overwrite.
3. Writes `.fenner-installed` JSON with Fenner commit SHA and path list.
4. **Path-2 themes** (e.g. mlresearch): skips `_layouts/*` by default so PMLR
   keeps `layout: default` wiring; includes still update. See
   [`cip/cip0001/mlresearch-notes.md`](cip/cip0001/mlresearch-notes.md).

**Tests:** `bats scripts/test/install-test.bats`

**Fixture render (CI primary):** `./scripts/pilot_build_fixture.sh` and
`./scripts/pilot_build_fixture.sh --path2` — Fenner-owned site under
`test/fixtures/site/` (CIP-0003). GitHub Actions: `.github/workflows/ci.yml`.

**Path-2 volume smoke (optional, local):** `./scripts/pilot_build_v16.sh` — builds
`~/mlresearch/v16` against a local `jekyll-theme` checkout.

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

- **CIP-0001** survey complete — manifest and notes in [`cip/cip0001/`](cip/cip0001/).
- **CIP-0002** install script shipped — templates extracted from `lawrennd/jekyll-theme`;
  run `script/install` into org themes. Pilot builds and rendering checks: CIP-0003.

## Licence

MIT — see [LICENSE.txt](LICENSE.txt).
