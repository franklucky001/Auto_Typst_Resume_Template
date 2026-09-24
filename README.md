# Typst Bilingual Resume Template

**[中文版](./readme-zh.md)**

An editable Chinese/English A4 resume template with local, Typst Web, and GitHub
Actions builds. Requires **Typst 0.15.1 or newer**; CI is pinned to **0.15.1**.
There are no Typst package dependencies.

| Chinese example | English example |
|:---:|:---:|
| ![Chinese resume](docs/Chinese.png) | ![English resume](docs/English.png) |

Template version: **3.0.0**. See the [release notes and migration guide](CHANGELOG.md).

## Quick start

1. Use this GitHub repository as a template.
2. Edit `src/chinese.typ` or `src/english.typ`.
3. Build locally or enable GitHub Actions and download the `resume-pdf` artifact.

For Typst Web, upload the repository files with their directory structure, select
one of the files in `src/` as the main file, and choose compiler version 0.15.1
or newer. The [older shared project](https://typst.app/project/r4XMUB3ENQUH7zWiuK7_tO)
is a historical copy and may not contain the current API.

## Local build

Install Typst and GNU Make. Run these commands **from the repository root**:

```sh
make             # Both PDFs: 个人简历.pdf and Resume.pdf
make zh          # Chinese only
make en          # English only
make -j2 all     # Build both in parallel
make check       # Compile and run regression checks; requires a POSIX shell
make clean       # Remove only the two generated PDFs
```

`make build` is an alias for `make all`. Building does not run cleanup.
The compiler can be overridden with `TYPST=/path/to/typst`.
To request Typst's PDF/UA-1 export checks when building:

```sh
make TYPST_FLAGS='--pdf-standard ua-1'
```

Without Make, compile directly:

```sh
typst compile --root . --font-path fonts src/chinese.typ 个人简历.pdf
typst compile --root . --font-path fonts src/english.typ Resume.pdf
```

### Fonts

- Chinese: **Noto Serif CJK SC**. On Debian/Ubuntu, install `fonts-noto-cjk`.
  Alternatively, download fonts from [Noto CJK](https://github.com/notofonts/noto-cjk)
  and place the files in `fonts/`. Do not put them in the repository root.
- English: **Libertinus Serif**, bundled with the official Typst CLI.
- Check available family names with `typst fonts --font-path fonts`. On Typst Web,
  select an available family or upload the required font files. A download named
  “Noto Serif SC” may expose a different family name from “Noto Serif CJK SC”;
  the `font` option must match the installed family.

## Editing the resume

Configuration lives in one document show rule. Paths are created in the source
file, so they keep their meaning when passed to the template:

```typ
#import "../template/template.typ": resume, contact, entry
#import "../template/icons.typ": fa-email

#show: resume.with(
  "San Zhang",
  lang: "en",
  font: "Libertinus Serif",
  // Optional; omit this parameter for no photo.
  // photo: path("../img/avatar.jpg"),
  contacts: (
    contact("me@example.org", icon: fa-email, dest: "mailto:me@example.org"),
  ),
)

= Education

#entry(
  "Example University",
  role: "Master of Engineering",
  details: "Computer Science",
  date: "2024–2027",
)
- *Achievement:* Describe a concrete result.
```

- `resume(name, ..., body)` requires the name and body; `show: resume.with(...)`
  supplies the body automatically. Defaults: `lang: "en"`,
  `font: "Libertinus Serif"`, `photo: none`, `contacts: ()`.
- Use `lang: "zh"` and `font: "Noto Serif CJK SC"` for Chinese. The template sets
  the PDF title, author, and text language. A photo occupies a 25 × 33 mm frame
  and is cropped to fit; its space is reserved in the header.
- `contact(body, icon: none, dest: none)` accepts display content, an optional
  rendered icon, and an optional link. Contacts wrap naturally; no fixed-height
  text boxes are used. Available icons: `fa-home`, `fa-email`, `fa-github`,
  `fa-linkedin`, `fa-phone`, `fa-weixin`. For a custom image, import `icon` and
  use `icon(path("../img/custom.svg"))`.
- `entry(title, role: none, details: none, date: none)` lays out title/role on the
  first row and details/date on the second. All fields accept text or content.
  Optional fields use `none`; the second row is omitted when both are absent.
  Each entry stays on one page. Put lengthy descriptions in the following list.
- Write sections as `= Heading` and descriptions as native bullet lists. Adjust
  shared typography and spacing in `template/template.typ`.

## Validation and automation

`make check` rejects compiler warnings and checks PDF/UA-1 export, heading/title
semantics, link destinations, language/author, optional fields, long fields,
caller-relative image paths, pagination, and safe cleanup. Fixed expectations
live in test fixtures, so changing your name, contacts, sections, or page count
does not require editing tests. Checks use temporary files and leave the
generated resumes untouched.

GitHub Actions runs checks and builds on pushes, pull requests, and manual runs.
Tag pushes additionally publish the two PDFs to GitHub Releases. Only the release
job has repository write permission. For an intentional release, create a version
tag and push that specific tag.

Compilation and PDF/UA checks do not guarantee correct parsing by every ATS or
full accessibility compliance. Inspect the PDF after changing fonts or content.
See [modernization notes and migration guide](CHANGELOG.md) for the
version-specific decisions and official references.

---

Since v2.1.0, this project is licensed under
[CC BY-NC 4.0](https://creativecommons.org/licenses/by-nc/4.0/).
Commercial use is not permitted.
