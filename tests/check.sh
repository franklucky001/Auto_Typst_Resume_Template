#!/bin/sh
set -eu

cd "$(dirname "$0")/.."
typst=${TYPST:-typst}
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT HUP INT TERM

# Any compiler warning (including missing fonts) fails validation.
run_typst() {
  if ! "$typst" "$@" 2>"$tmp/diagnostics"; then
    cat "$tmp/diagnostics" >&2
    exit 1
  fi
  if [ -s "$tmp/diagnostics" ]; then
    cat "$tmp/diagnostics" >&2
    exit 1
  fi
}

# User-editable examples must compile but need not keep sample names or content.
for source in src/chinese.typ src/english.typ tests/fixtures/layout.typ tests/minimal.typ; do
  name=$(basename "$source" .typ)
  run_typst compile --root . --font-path fonts --pdf-standard ua-1 \
    "$source" "$tmp/$name.pdf"
done
run_typst compile --root . --font-path fonts --pdf-standard ua-1 \
  --input lang=zh tests/minimal.typ "$tmp/minimal-zh.pdf"

run_typst eval --root . --font-path fonts --in tests/fixtures/layout.typ '{
  let headings = query(heading)
  assert.eq(headings.len(), 3)
  assert(headings.all(it => it.level == 1))
  assert.eq(query(title).len(), 1)
  assert.eq(query(link).map(it => it.dest), ("mailto:person@example.org",))
}' > /dev/null

# Verify cleanup in isolation, including paths containing spaces.
mkdir -p "$tmp/clean/nested directory"
cp makefile "$tmp/clean/makefile"
touch "$tmp/clean/个人简历.pdf" "$tmp/clean/Resume.pdf" \
  "$tmp/clean/keep.pdf" "$tmp/clean/nested directory/keep.pdf"
make -s -C "$tmp/clean" clean
test ! -e "$tmp/clean/个人简历.pdf"
test ! -e "$tmp/clean/Resume.pdf"
test -f "$tmp/clean/keep.pdf"
test -f "$tmp/clean/nested directory/keep.pdf"

echo "PDF/UA export, document semantics, layout fixtures, and safe cleanup passed."
