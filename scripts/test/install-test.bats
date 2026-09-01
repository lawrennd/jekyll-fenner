#!/usr/bin/env bats

FENNER_ROOT="$(cd "${BATS_TEST_DIRNAME}/../.." && pwd)"
INSTALL="$FENNER_ROOT/script/install"
FIXTURE="$BATS_TEST_DIRNAME/fixtures/minimal-theme"
PATH2_FIXTURE="$BATS_TEST_DIRNAME/fixtures/path2-theme"

setup() {
  TEST_THEME="$FENNER_ROOT/scripts/test/tmp/test-theme-$$-$RANDOM"
  mkdir -p "$FENNER_ROOT/scripts/test/tmp"
  cp -a "$FIXTURE/." "$TEST_THEME/"
  git -C "$TEST_THEME" init -q
  git -C "$TEST_THEME" config user.email "test@example.com"
  git -C "$TEST_THEME" config user.name "Test"
  git -C "$TEST_THEME" add -A
  git -C "$TEST_THEME" commit -q -m "fixture"
}

teardown() {
  rm -rf "$TEST_THEME"
}

@test "dry-run makes no writes" {
  header_before="$(cat "$TEST_THEME/_includes/header.html")"
  run env FENNER_ROOT="$FENNER_ROOT" "$INSTALL" --dry-run "$TEST_THEME"
  [ "$status" -eq 0 ]
  [[ "$output" == *"dry-run complete"* ]]
  [ "$(cat "$TEST_THEME/_includes/header.html")" = "$header_before" ]
  [ ! -f "$TEST_THEME/.fenner-installed" ]
}

@test "install creates manifest files and stamp" {
  run env FENNER_ROOT="$FENNER_ROOT" "$INSTALL" "$TEST_THEME"
  [ "$status" -eq 0 ]
  [ -f "$TEST_THEME/_includes/seo-info.html" ]
  [ -f "$TEST_THEME/.fenner-installed" ]
  grep -q fenner_commit "$TEST_THEME/.fenner-installed"
}

@test "second install is idempotent" {
  env FENNER_ROOT="$FENNER_ROOT" "$INSTALL" "$TEST_THEME" >/dev/null
  find "$TEST_THEME/_includes" -type f -print0 | sort -z | xargs -0 shasum -a 256 > /tmp/fenner-before.txt
  run env FENNER_ROOT="$FENNER_ROOT" "$INSTALL" "$TEST_THEME"
  [ "$status" -eq 0 ]
  find "$TEST_THEME/_includes" -type f -print0 | sort -z | xargs -0 shasum -a 256 > /tmp/fenner-after.txt
  diff /tmp/fenner-before.txt /tmp/fenner-after.txt
}

@test "chrome header.html is untouched" {
  header_before="$(cat "$TEST_THEME/_includes/header.html")"
  env FENNER_ROOT="$FENNER_ROOT" "$INSTALL" "$TEST_THEME" >/dev/null
  [ "$(cat "$TEST_THEME/_includes/header.html")" = "$header_before" ]
}

@test "path-2 theme skips type layouts by default" {
  rm -rf "$TEST_THEME"
  TEST_THEME="$FENNER_ROOT/scripts/test/tmp/path2-theme-$$-$RANDOM"
  mkdir -p "$FENNER_ROOT/scripts/test/tmp"
  cp -a "$PATH2_FIXTURE/." "$TEST_THEME/"
  git -C "$TEST_THEME" init -q
  git -C "$TEST_THEME" config user.email "test@example.com"
  git -C "$TEST_THEME" config user.name "Test"
  git -C "$TEST_THEME" add -A
  git -C "$TEST_THEME" commit -q -m "fixture"

  article_before="$(cat "$TEST_THEME/_layouts/article.html")"
  run env FENNER_ROOT="$FENNER_ROOT" "$INSTALL" "$TEST_THEME"
  [ "$status" -eq 0 ]
  [ "$(cat "$TEST_THEME/_layouts/article.html")" = "$article_before" ]
  [[ "$output" == *"path-2 theme detected"* ]]
  [ -f "$TEST_THEME/_includes/paper_abstract.html" ]
}

@test "refuses to install into fenner root" {
  run env FENNER_ROOT="$FENNER_ROOT" "$INSTALL" "$FENNER_ROOT"
  [ "$status" -ne 0 ]
  [[ "$output" == *"refusing to install Fenner into itself"* ]]
}
