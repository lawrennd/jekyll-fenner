#!/usr/bin/env bash
# CIP-0003 Layers 2–4: build Fenner-owned fixture site (path-1 or path-2).
#
# Does not require sibling org theme or volume checkouts — CI-friendly.
#
# Usage:
#   ./scripts/pilot_build_fixture.sh           # path-1 (publication body)
#   ./scripts/pilot_build_fixture.sh --path2   # path-2 (paper_abstract body)
#   DEST=/tmp/out ./scripts/pilot_build_fixture.sh
set -euo pipefail

FENNER_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FIXTURE="${FIXTURE:-$FENNER_ROOT/test/fixtures/site}"
MANIFEST="${FENNER_MANIFEST:-$FENNER_ROOT/cip/cip0001/fenner-owned-paths.txt}"
DEST="${DEST:-$FENNER_ROOT/_site/fixture}"
STAGE=""
PATH2=0

usage() {
  cat <<EOF
Usage: $0 [--path2]

Build the Fenner fixture site with Fenner-owned templates linked in.

  --path2     Use path-2 type layouts (default + paper_abstract)
  DEST=dir    Jekyll destination (default: $FENNER_ROOT/_site/fixture)
  FIXTURE=dir Fixture root (default: test/fixtures/site)
  JEKYLL=bin  jekyll executable
EOF
}

log() { printf '%s\n' "$*"; }
die() { log "error: $*" >&2; exit 1; }

cleanup() {
  [[ -n "$STAGE" && -d "$STAGE" ]] && rm -rf "$STAGE"
}
trap cleanup EXIT

while [[ $# -gt 0 ]]; do
  case "$1" in
    --path2) PATH2=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) die "unknown argument: $1" ;;
  esac
done

_resolve_jekyll() {
  local cand
  if [[ -n "${JEKYLL:-}" ]]; then
    printf '%s\n' "$JEKYLL"
    return
  fi
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
[[ -d "$FIXTURE/_posts" ]] || die "fixture posts missing: $FIXTURE/_posts"
[[ -f "$MANIFEST" ]] || die "manifest missing: $MANIFEST"

STAGE="$(mktemp -d -t fenner-fixture.XXXXXX)"
# Copy fixture chrome/posts; then overlay Fenner-owned paths from the repo.
cp -a "$FIXTURE/." "$STAGE/"

while IFS= read -r line || [[ -n "$line" ]]; do
  path="${line%%#*}"
  path="$(echo "$path" | sed 's/[[:space:]]*$//;s/^[[:space:]]*//')"
  [[ -z "$path" ]] && continue
  src="$FENNER_ROOT/$path"
  [[ -e "$src" ]] || die "Fenner path missing: $path"
  mkdir -p "$(dirname "$STAGE/$path")"
  # Prefer hard link / copy so Stage is self-contained under /tmp.
  rm -rf "$STAGE/$path"
  cp -a "$src" "$STAGE/$path"
done <"$MANIFEST"

if [[ "$PATH2" -eq 1 ]]; then
  [[ -d "$FIXTURE/path2-layouts" ]] || die "path2-layouts missing in fixture"
  cp -a "$FIXTURE/path2-layouts/." "$STAGE/_layouts/"
  MODE="path-2"
else
  MODE="path-1"
fi

# Avoid fixture Gemfile pulling bundler into a broken github-pages world.
if [[ -f "$STAGE/Gemfile" ]]; then
  mv "$STAGE/Gemfile" "$STAGE/Gemfile.fixture-bak"
fi

log "building fixture ($MODE) → $DEST"
rm -rf "$DEST"
"$JEKYLL_BIN" build --source "$STAGE" --destination "$DEST" --config "$STAGE/_config.yml"

assert_file() {
  local f="$1"
  [[ -f "$DEST/$f" ]] || die "missing built page: $f"
}

assert_grep() {
  local pattern="$1" file="$2" label="$3"
  if ! grep -q -- "$pattern" "$DEST/$file"; then
    die "assertion failed ($label): /$pattern/ not in $file"
  fi
}

assert_file "index.html"
assert_file "article-csl.html"
assert_file "inproceedings-minimal.html"
assert_file "techreport-legacy.html"
assert_file "report-delve.html"

# Shared assertions (REQ-0002/0003 smoke)
assert_grep "Approximating Posterior Distributions" "article-csl.html" "article title"
assert_grep "Bishop" "article-csl.html" "article author"
assert_grep "Cite this Paper" "article-csl.html" "article cite UI"
assert_grep "citation_title" "article-csl.html" "article scholar meta"
assert_grep "10.5555/fixture.article" "article-csl.html" "article DOI"

assert_grep "Active Learning with Clustering" "inproceedings-minimal.html" "inproc title"
assert_grep "Cite this Paper" "inproceedings-minimal.html" "inproc cite UI"
assert_grep "container-title\|Active Learning and Experimental Design" "inproceedings-minimal.html" "inproc venue"

assert_grep "Legacy Techreport" "techreport-legacy.html" "techreport title"
assert_grep "Cite this Paper" "techreport-legacy.html" "techreport cite UI"

assert_grep "Fixture DELVE-style Report" "report-delve.html" "report title"
assert_grep "Citation\|Cite this Paper\|DELVE Report" "report-delve.html" "report citation"

# Path encoding smoke
if [[ "$PATH2" -eq 1 ]]; then
  assert_grep 'id="abstract"\|class="abstract"' "article-csl.html" "path-2 abstract markup"
else
  assert_grep "paper-details__abstract\|Cite this Paper" "article-csl.html" "path-1 body markup"
fi

# CiteProc export page exists when Fenner asset copied
[[ -f "$DEST/assets/bib/citeproc.yaml" ]] \
  || die "missing assets/bib/citeproc.yaml"
assert_grep "Approximating Posterior Distributions" "assets/bib/citeproc.yaml" "citeproc title"

html_count="$(find "$DEST" -name '*.html' | wc -l | tr -d ' ')"
log "fixture build OK ($MODE)"
log "  html pages:  $html_count"
log "  destination: $DEST"
