#import "../template/template.typ": resume, entry

// No photo, no contacts, and no optional entry fields; test both languages.
#let lang = sys.inputs.at("lang", default: "en")
#show: resume.with(
  "Minimal Resume",
  lang: lang,
  font: if lang == "zh" { "Noto Serif CJK SC" } else { "Libertinus Serif" },
)

= Education

#entry("University")

#context {
  assert.eq(counter(page).final().first(), 1)
  assert.eq(text.lang, lang)
  assert(document.author.contains("Minimal Resume"))
}
