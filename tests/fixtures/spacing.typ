#import "../../template/template.typ": resume, entry
#show: resume.with(
  "Centered Name",
  photo: path("../../img/avatar.jpg"),
  contacts: ([#box[Contact information] <contact-box>],),
)

// Entry spacing must follow the caller's paragraph leading.
#set par(leading: 1em)

= Education

#entry(
  [#metadata("first") <first-row>University],
  details: [#metadata("second") <second-row>Research field],
)
#entry([#metadata("next") <next-entry>Another university])
- #metadata("body") <following-list>Description

#context {
  let contact-box = query(<contact-box>).first()
  let center-x = contact-box.location().position().x + measure(contact-box).width / 2
  assert(calc.abs(center-x - page.width / 2) < 0.1pt,
    message: "Contacts must be centered on the page, independently of the photo")
  assert(locate(<second-row>).position().y - locate(<first-row>).position().y >= 16pt,
    message: "Entry rows must retain readable line spacing")
  assert(locate(<next-entry>).position().y - locate(<second-row>).position().y >= 18pt,
    message: "Separate entries need visible vertical spacing")
  assert(locate(<following-list>).position().y - locate(<next-entry>).position().y >= 18pt,
    message: "Descriptions must not crowd entry headers")
}
