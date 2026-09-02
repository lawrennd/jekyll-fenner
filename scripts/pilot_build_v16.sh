#!/usr/bin/env bash
# CIP-0003 Layer 4: path-2 smoke build of a PMLR volume against a local theme.
#
# Symlinks mlresearch/jekyll-theme layouts/includes into a volume site (default
# v16), builds with system Jekyll (no github-pages bundle required), and checks
# that a paper page and the volume index render citation / listing markup.
#
# Usage:
#   ./scripts/pilot_build_v16.sh
#   THEME=/path/to/jekyll-theme SITE=/path/to/v16 DEST=/tmp/out ./scripts/pilot_build_v16.sh
#
# Notes:
# - Theme SCSS with Liquid in @import fails under Jekyll 4.4 + dart-sass; those
#   stylesheets are excluded here. HTML/citation rendering is what we validate.
# - For production-parity CSS + remote_theme, use the volume's own Gemfile:
#     cd "$SITE" && bundle install && bundle exec jekyll build
set -euo pipefail

FENNER_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# Common checkouts: ~/mlresearch/... (sibling of ~/lawrennd) or env override.
_default_theme() {
  local cand
  for cand in \
    "${HOME}/mlresearch/jekyll-theme" \
    "${FENNER_ROOT}/../mlresearch/jekyll-theme" \
    "${FENNER_ROOT}/../../mlresearch/jekyll-theme"; do
    [[ -d "$cand/_layouts" ]] && { printf '%s\n' "$cand"; return; }
  done
  printf '%s\n' "${HOME}/mlresearch/jekyll-theme"
}
_default_site() {
  local cand
  for cand in \
    "${HOME}/mlresearch/v16" \
    "${FENNER_ROOT}/../mlresearch/v16" \
    "${FENNER_ROOT}/../../mlresearch/v16"; do
    [[ -f "$cand/_config.yml" ]] && { printf '%s\n' "$cand"; return; }
  done
  printf '%s\n' "${HOME}/mlresearch/v16"
}
THEME="${THEME:-$(_default_theme)}"
SITE="${SITE:-$(_default_site)}"
DEST="${DEST:-/tmp/v16-jekyll-build}"
PAPER_SAMPLE="${PAPER_SAMPLE:-guyon11a.html}"
OVERLAY=""
MOVED_GEMFILE=0
SYMLINKS=()

usage() {
  cat <<EOF
Usage: $0

Environment:
  THEME          Local mlresearch/jekyll-theme
                 (default: ~/mlresearch/jekyll-theme if present)
  SITE           Volume content repo (default: ~/mlresearch/v16 if present)
  DEST           Jekyll destination (default: /tmp/v16-jekyll-build)
  PAPER_SAMPLE   Built paper HTML to assert (default: guyon11a.html)
  JEKYLL         jekyll executable (default: jekyll on PATH)
EOF
}

log() { printf '%s\n' "$*"; }
die() { log "error: $*" >&2; exit 1; }

cleanup() {
  local link
  for link in "${SYMLINKS[@]+"${SYMLINKS[@]}"}"; do
    [[ -e "$link" || -L "$link" ]] && rm -f "$link"
  done
  # Drop empty dirs we may have created under assets/
  [[ -d "$SITE/assets/css" ]] && rmdir "$SITE/assets/css" 2>/dev/null || true
  [[ -d "$SITE/assets" ]] && rmdir "$SITE/assets" 2>/dev/null || true
  if [[ "$MOVED_GEMFILE" -eq 1 && -f "$SITE/Gemfile.pilot-bak" ]]; then
    mv "$SITE/Gemfile.pilot-bak" "$SITE/Gemfile"
  fi
  [[ -n "$OVERLAY" && -f "$OVERLAY" ]] && rm -f "$OVERLAY"
}
trap cleanup EXIT

[[ "${1:-}" == "-h" || "${1:-}" == "--help" ]] && { usage; exit 0; }

_resolve_jekyll() {
  local cand
  if [[ -n "${JEKYLL:-}" ]]; then
    printf '%s\n' "$JEKYLL"
    return
  fi
  # Prefer rbenv/user gems; Homebrew jekyll often has a stale Ruby shebang.
  for cand in \
    "${HOME}/.rbenv/shims/jekyll" \
    "${HOME}/gems/bin/jekyll" \
    "$(command -v jekyll 2>/dev/null || true)"; do
    [[ -n "$cand" && -x "$cand" ]] || continue
    if "$cand" --version >/dev/null 2>&1; then
      printf '%s\n' "$cand"
      return
    fi
  done
  return 1
}

JEKYLL_BIN="$(_resolve_jekyll)" || die "jekyll not found (set JEKYLL=...)"

[[ -d "$THEME/_layouts" ]] || die "theme layouts missing: $THEME/_layouts"
[[ -d "$THEME/_includes" ]] || die "theme includes missing: $THEME/_includes"
[[ -f "$SITE/_config.yml" ]] || die "site config missing: $SITE/_config.yml"
[[ -f "$SITE/index.html" ]] || die "site index missing: $SITE/index.html"

# Require paper_abstract (restored checkout); fail early if includes were deleted.
[[ -f "$THEME/_includes/paper_abstract.html" ]] \
  || die "missing $THEME/_includes/paper_abstract.html — restore theme checkout first"

OVERLAY="$(mktemp -t fenner-v16-overlay)"
OVERLAY_YML="${OVERLAY}.yml"
mv "$OVERLAY" "$OVERLAY_YML"
OVERLAY="$OVERLAY_YML"
cat >"$OVERLAY" <<'YAML'
# Pilot overlay: local theme via symlinks; skip remote_theme fetch.
remote_theme:
plugins:
  - jekyll-feed
  - jekyll-seo-tag
# Liquid-in-SCSS skins break under Jekyll 4.4 + dart-sass; HTML is the pilot target.
exclude:
  - assets/css/aistats.scss
  - assets/css/dmlr.scss
  - assets/css/delve.scss
  - assets/css/dali.scss
  - assets/css/gpss.scss
  - assets/css/mlatcl.scss
  - assets/css/ndltalk.scss
  - assets/css/style.scss
  - assets/css/talks.scss
  - assets/css/pmlr.scss
YAML

cd "$SITE"

if [[ -f Gemfile ]]; then
  mv Gemfile Gemfile.pilot-bak
  MOVED_GEMFILE=1
fi

link_theme() {
  local name="$1" src="$2"
  local target="$SITE/$name"
  [[ -e "$target" || -L "$target" ]] && die "refusing to overwrite existing $target"
  ln -sfn "$src" "$target"
  SYMLINKS+=("$target")
}

link_theme "_layouts" "$THEME/_layouts"
link_theme "_includes" "$THEME/_includes"
link_theme "_sass" "$THEME/_sass"

mkdir -p "$SITE/assets"
for asset in bib images rss; do
  if [[ -d "$THEME/assets/$asset" ]]; then
    link_theme "assets/$asset" "$THEME/assets/$asset"
  fi
done

log "building $SITE → $DEST"
log "  theme: $THEME"
rm -rf "$DEST"
"$JEKYLL_BIN" build \
  --source "$SITE" \
  --destination "$DEST" \
  --config "$SITE/_config.yml,$OVERLAY"

[[ -f "$DEST/index.html" ]] || die "build produced no index.html"
[[ -f "$DEST/$PAPER_SAMPLE" ]] || die "build produced no $PAPER_SAMPLE"

paper_cites="$(grep -c 'Cite this Paper' "$DEST/$PAPER_SAMPLE" || true)"
index_papers="$(grep -c 'class="paper"' "$DEST/index.html" || true)"
html_count="$(find "$DEST" -name '*.html' | wc -l | tr -d ' ')"

[[ "$paper_cites" -ge 1 ]] || die "$PAPER_SAMPLE missing 'Cite this Paper'"
[[ "$index_papers" -ge 1 ]] || die "index.html missing class=\"paper\" listings"

log "pilot build OK"
log "  html pages:     $html_count"
log "  paper cites:    $paper_cites ($PAPER_SAMPLE)"
log "  index listings: $index_papers"
log "  destination:    $DEST"
