# Changelog

## 3.0.0 — 2026-09-24

This major release modernizes the bilingual resume template for **Typst 0.15.1+**.
The template source API has breaking changes; both bundled examples are migrated.

本次大版本面向 **Typst 0.15.1+**，包含不兼容的源码接口变更。
仓库内的中英文示例已完成迁移。

### Changes / 主要变化

- One `resume.with(...)` document configuration replaces separate template and
  initialization calls. Metadata, language, typography, and header share one scope.
- Native title, headings, lists, and links preserve PDF semantics. Decorative
  icons use `pdf.artifact`; images passed between modules use `path(...)`.
- A header grid reserves space for the photo. Named entry fields wrap in separate
  columns and stay together across page breaks.
- Corrected email/telephone links, explicit Chinese language settings, and bundled
  Libertinus Serif for English. Updated both preview images and READMEs.
- Parallel-safe builds, cleanup limited to the two generated PDFs, and regression
  checks for PDF/UA export, metadata, layout, relative paths, and safe cleanup.
- CI pins Typst 0.15.1, validates pull requests, and gives write permission only
  to the tag-triggered release job.

### Migration / 迁移

Old API aliases are intentionally removed. Update custom resumes using this table:

旧接口不保留兼容别名；自定义简历请按下表迁移：

| Before / 旧写法 | After / 新写法 |
|---|---|
| `#show: template` and `#init(name: "…")` | `#show: resume.with("…", ...)` |
| `pic_path: ""` | Omit `photo`, or use `photo: none` |
| `pic_path: "/img/avatar.jpg"` | From `src/`: `photo: path("../img/avatar.jpg")` |
| `#info((icon: ..., link: ..., content: ...), ...)` | `contacts: (contact(content, icon: ..., dest: ...), ...)` |
| Transitive imports of `fa_email`, etc. | Explicit imports of `fa-email`, etc. from `template/icons.typ` |
| `#resume_section("Education")` | `= Education` |
| `#resume_item(a, b, c, d)` | `#entry(a, role: b, details: c, date: d)` |
| `#resume_desc("Label", content)` | `- *Label:* content` (prefix expressions with `#`) |
| `chiline()` | The heading's block style supplies the separator |

Use `none` for omitted optional fields. Create `path(...)` values in the calling
source file. Put long descriptions in normal lists after an entry. Run build
commands from the repository root, and put local fonts in `fonts/`.

可选字段统一用 `none`；图片路径在调用方创建。较长描述放在条目之后的原生列表里。
构建命令从仓库根目录执行，本地字体放入 `fonts/`。

### Official references / 官方依据

- [Typst 0.14](https://typst.app/docs/changelog/0.14.0/): PDF artifacts.
- [Typst 0.15 migration guide](https://typst.app/docs/changelog/0.15.0/#migration-guide):
  path values and improved baseline handling.
- [Typst 0.15.1](https://typst.app/docs/changelog/0.15.1/): corrected failure exit
  status for `typst eval`, used by the regression checks.
- [Accessibility guide](https://typst.app/docs/guides/accessibility/): native
  semantic elements, reading order, and decorative content.

### Validation / 验证

Validated locally with Typst 0.15.1: `make check`, `make -j2 all`, shell syntax,
workflow static analysis, and `git diff --check`. Both sample PDFs were visually
reviewed and remain one A4 page. Hosted CI runs after pushing; Typst's PDF/UA
checks do not constitute independent accessibility certification or guarantee
compatibility with every ATS.
