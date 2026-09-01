# CIP-0001: Git history notes

Survey date: 2026-09-01. Commands run against local checkouts where present;
path-2 timelines confirmed on GitHub default branches via snapshot dates and
`mlresearch/jekyll-theme` history.

Reproduce inventory: `python3 scripts/survey_theme_inventory.py`

## Path-1 vs path-2 split (`article.html`)

**Path-1** (lawrennd, mlatcl, uk-ai, datatrustsinitiative, acceleratescience):
`article.html` sets `layout: publication` and includes
`paper_authors_abstract_links.html`.

**Path-2** (aistats, gpschool, mlresearch, mlr-datasets, dalimeeting, rs-delve):
`article.html` sets `layout: default` and includes `paper_abstract.html`.

On `lawrennd/jekyll-theme`, both body includes coexist. The path-1 split landed
in April 2022:

| Commit | Date | Change |
|--------|------|--------|
| `d504225` | 2022-04-13 | Type layouts switch to `layout: publication`; `paper_abstract` thinned |
| `9a71e93` | 2022-04-14 | `paper_authors_abstract_links.html` introduced as rich body |
| `4c0c942` | 2022-04-17 | `publication.html` shell updated for citation links |

On `mlresearch/jekyll-theme`, `article.html` last changed in commit `2fa8a5c`
(2020-12-06) and still uses the path-2 wiring. Path-2 themes did not adopt the
2022 publication-layout refactor.

## `paper_abstract.html` vs `paper_authors_abstract_links.html`

Both files exist on path-1 themes (legacy + rich body). Path-2 themes ship
`paper_abstract.html` only; `paper_authors_abstract_links.html` is absent.

`paper_abstract.html` predates the 2022 refactor (lawrennd history back to
2022-01-22 link work). The rich include was added when publication chrome moved
venue/authors/export into a dedicated layout stack.

**Survey finding:** `paper_abstract.html` is byte-identical across ten themes;
`dalimeeting/jekyll-theme` (`dali` branch) alone differs.

## `publication.html` (theme-local chrome)

Present on path-1 themes only. Snapshot status:

| Theme | vs lawrennd baseline |
|-------|----------------------|
| lawrennd, mlatcl | IDENTICAL |
| uk-ai, datatrustsinitiative, acceleratescience | DIFFERS (org chrome) |

uk-ai last touched `publication.html` in `6369e4d` (2023-03-06) for people-card
linking. acceleratescience uses Foundation-style chrome on the same path-1
wiring.

**Decision:** `publication.html` stays theme-local (REQ-0001). Fenner does not
install a shared shell.

## Copy / export stack (`copy_sections`, `*_entry`, `*_copy_section`)

Copy UI landed incrementally on lawrennd:

| Commit | Date | Change |
|--------|------|--------|
| `0bc9e77` | 2020-08-10 | Multi-format copy buttons |
| `3189b62` | 2020-11-23 | BibTeX copy sections |
| `59a1bd9` | 2022-04-13 | Button placement with publication refactor |

Path-1 themes: copy stack byte-identical to lawrennd. Path-2 themes: same files
present but several DIFFER from lawrennd baseline (older fork copies). Fenner
should install the lawrennd canonical versions.

## `extractinfo_publication.html`

Last shared update on lawrennd/mlatcl/uk-ai/datatrustsinitiative:
`edfa102` (2022-04-18, `relative_url` filter move).

Path-2 themes carry older variants (DIFFERS). `dalimeeting` lacks the file on
the `dali` branch. Fenner owns the lawrennd version as the normalisation
boundary (REQ-0003).

## `seo-info.html` and paper meta includes

`seo-info.html` dates to `5a88f80` (2020-11-23) on lawrennd. Path-1 cluster
identical; path-2 differs on six themes (same era fork drift).

Google Scholar / Open Graph / Twitter includes: identical on path-1; path-2
differs — same pattern as SEO stack.

## `assets/bib/citeproc.yaml`

Shared across all eleven themes. Last common substantive edit referenced in
lawrennd history: `7054d83` (2021-03-30, prefix/suffix). `dalimeeting` alone
DIFFERS on the `dali` branch.

## lawrennd vs mlatcl drift

Byte compare on core publication files (local checkouts):

```
_includes/paper_authors_abstract_links.html  IDENTICAL
_includes/extractinfo_publication.html       IDENTICAL
_includes/copy_sections.html                 IDENTICAL
_includes/seo-info.html                      IDENTICAL
_layouts/article.html                        IDENTICAL
```

mlatcl has not diverged from lawrennd on the publication core since the 2022
refactor. uk-ai/datatrustsinitiative/acceleratescience diverge only in
`publication.html` chrome.

## `cite-as.html` (report-style pages)

Identical across path-1. Path-2 themes (including rs-delve) differ — rs-delve
tunes cite-as for DELVE report/addendum layouts. Fenner ships lawrennd canonical;
rs-delve may keep a theme-local override outside the install manifest.
