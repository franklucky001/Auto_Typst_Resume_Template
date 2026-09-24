#import "../template/template.typ": resume, contact, entry
#import "../template/icons.typ": fa-home, fa-email, fa-phone, fa-github

#show: resume.with(
  "San Zhang",
  lang: "en",
  font: "Libertinus Serif",
  contacts: (
    contact("zhangsan.io", icon: fa-home, dest: "https://zhangsan.io/"),
    contact("NorthSecond", icon: fa-github, dest: "https://github.com/NorthSecond"),
    contact("me@zhangsan.io", icon: fa-email, dest: "mailto:me@zhangsan.io"),
    contact("+86 133 3333 3333", icon: fa-phone, dest: "tel:+8613333333333"),
  ),
)

= Education

#entry(
  "XXX University",
  role: "Master of Engineering",
  details: "Computer Science and Technology",
  date: "2024.09 -- 2027.07",
)

#entry(
  "XXXX University",
  role: "Bachelor of Engineering",
  details: "Software Engineering",
  date: "2020.09 -- 2024.06",
)

= Publications

- [CVPR 2024] *You*, #lorem(5), and #lorem(1). "#lorem(10)" Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition. 2024.
- [CVPR 2023] *You*, #lorem(5), and #lorem(1). "#lorem(10)" Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition. 2023.

= Selected Projects

#entry(
  lorem(5),
  role: "Computer Architecture",
  details: lorem(8),
  date: "2023.12 -- 2026.11",
)
- *Description:* #lorem(32)
- *Contribution:* #lorem(24)
- *Achievement:* #lorem(12)

= Experience

#entry(
  lorem(8),
  role: "Student Assistant",
  details: lorem(3),
  date: "2021.11 -- 2024.06",
)
- *Description:* #lorem(24)

= Competitions and Awards
- *Professional Skills Competition:* #lorem(8)
- *Scholarship:* #lorem(24)
- *Other Administrative Awards:* #lorem(12)

= Skills and Interests
- *Programming Languages:* Proficient in C/C++; familiar with Rust, Python; have experience in Java, SQL, Matlab, TypeScript, Golang and some other languages.
- *Development Tools:* Proficient in Git, Docker, Kubernetes, familiar with Jenkins, Travis CI, Circle CI, etc.
- *Interests:* Machine Learning, Computer Vision, Compiler, System Programming, etc.
