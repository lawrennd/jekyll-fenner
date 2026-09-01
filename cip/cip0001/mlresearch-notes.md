# mlresearch/jekyll-theme and PMLR

Survey date: 2026-09-01. Branch: `master`. See also `survey-matrix.csv`.

## Role

`mlresearch/jekyll-theme` drives PMLR volume sites (e.g. `mlresearch/v16`).
Content repos use stable public layout names (`layout: inproceedings`, etc.)
with CSL-shaped front matter. The theme is the **path-2 reference** for that
cluster, not a third parallel stack.

## Path encoding

Path-2 wiring (shared with aistats, gpschool, mlr-datasets):

- Type layouts → `layout: default` + `{% include paper_abstract.html %}`
- No `publication.html`, no `paper_authors_abstract_links.html`

Path-1 themes (lawrennd, mlatcl) switched to `layout: publication` + rich body
in April 2022. mlresearch `article.html` last changed December 2020 and stayed
on path-2.

## Byte identity vs lawrennd (GitHub `master`)

**Identical to lawrennd** — same CiteProc/export core:

- `paper_abstract.html`, `seo-info.html`
- All `*_entry` and `*_copy_section` includes
- `assets/bib/citeproc.yaml`, `listauthors.html`

**Differs from lawrennd** — path-2 cluster pattern (mostly shared with aistats):

- Type layouts (`article`, `inproceedings`, `techreport`, …)
- `listpaper.html` — PMLR listing markup (`paper` / `title` / `details`)
- `copy_sections.html` — extra `<hr class="bibhr">` wrappers
- Paper SEO metas (`paper_google_scholar`, open graph, twitter)
- `cite-as.html`, `copy_buttons.html`, `hidden_copy_code.html`

**Differs even within path-2:**

- `extractinfo_publication.html` — PMLR tweaks: `site.publisher`, `site.date`
  fallbacks; `site.url`+`site.baseurl` instead of `relative_url` filter

## Within path-2 cluster

mlresearch is **aligned** with aistats / mlr-datasets / gpschool on:

- `article.html`, `paper_abstract.html`, `listpaper.html`, `copy_sections.html`

It is **not** byte-identical to aistats on `extractinfo_publication.html` or
`copy_buttons.html`.

## Fenner implications

1. **Do not rename PMLR content layouts** — posts keep `inproceedings`, etc.
2. **Do not overwrite path-2 type layouts by default** — keep theme-local
   `article.html` (`layout: default`) until opt-in migration (CIP-0001 option C).
3. **Blind lawrennd copy breaks PMLR** if it replaces `listpaper.html` or
   PMLR-tuned `extractinfo_publication.html` without merging fallbacks.
4. **Install policy:** Fenner ships lawrennd canonical includes; path-2 themes
   get `--dry-run` warnings on high-drift files. Future work: merge PMLR
   `extractinfo` fallbacks into Fenner normalisation before forcing overwrite
   on mlresearch.

## Reproduce

```bash
python3 scripts/survey_theme_inventory.py
# mlresearch rows in cip/cip0001/survey-matrix.csv
```
