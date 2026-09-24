#import "../../template/template.typ": resume, contact, entry
#import "../../template/icons.typ": icon

// Paths originate here, not in the helper module's directory.
#show: resume.with(
  "A Candidate With A Long Name",
  photo: path("../../img/avatar.jpg"),
  contacts: (
    contact("Plain text without an icon or link"),
    contact("Email", dest: "mailto:person@example.org"),
    contact("Custom icon", icon: icon(path("../../img/fa/fa-home.svg"))),
    contact([A long contact label that can wrap naturally within the header]),
  ),
)

= Optional fields

#entry("Title only")
#entry("Role only", role: "Engineer")
#entry("Details only", details: [*Rich text* details])
#entry("Date only", date: "2024–2026")

= Long fields

#entry(
  [A long institution name that must wrap rather than collide with the role],
  role: [A long role that also wraps inside its own column],
  details: [A long description of the department and location with more text],
  date: [September 2024 – September 2026 (expected)],
)
- *Description:* Details remain a real list item.

// Force a heading/entry near a page boundary and check that neither is split.
#context v(page.height - 1.3cm - here().position().y - 1em)
= Kept with its entry <boundary-heading>
#entry(
  [Boundary title #metadata("title") <entry-title>],
  details: [Boundary details #metadata("details") <entry-details>],
)

#context {
  assert.eq(locate(<boundary-heading>).page(), 2)
  assert.eq(locate(<boundary-heading>).page(), locate(<entry-title>).page())
  assert.eq(locate(<entry-title>).page(), locate(<entry-details>).page())
  assert(query(heading).first().location().position().y > 1.3cm + 33mm,
    message: "The photo must reserve space above the first section")
}

// A long list is allowed to break across pages.
#for i in range(30) [
  - *Achievement #i:* #lorem(30)
]
