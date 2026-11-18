#import "../vendor/grotesk-cv/lib.typ": cv
#import "common.typ": *
#let metadata = toml("grotesk.toml")

#let section(title, body) = block(above: 16pt, below: 5pt)[
  #text(size: 13pt, weight: "bold", title)
  #v(5pt)
  #body
]

#let entry(record) = block(breakable: false, above: 9pt, below: 3pt)[
  #text(weight: "bold", size: 11pt, record.title)
  #linebreak()
  #text(style: "italic", record.organization)
  #linebreak()
  #text(fill: rgb("63636a"), size: 10pt, record.dates)
  #v(3pt)
  #list(..record.bullets)
]

#let project-entry(record) = block(breakable: false, above: 9pt, below: 4pt)[
  #text(weight: "bold")[#if record.url != none { link(record.url, record.title) } else { record.title }]
  #linebreak()
  #text(size: 10pt, style: "italic", record.dates)
  #v(3pt)
  #list(..record.bullets)
]

#let sidebar(full: false) = {
  section("Technical Skills", {
    for group in skills {
      block(above: 7pt)[
        #text(weight: "bold", group.label)
        #v(3pt)
        #for skill in group.text.split(", ") {
          box(inset: (x: 4pt, y: 2pt), radius: 2pt, fill: rgb("dedcd6"), text(size: 10pt, skill))
          h(3pt)
        }
      ]
    }
  })
  section("Education", degree)
  section("Certifications", credentials(full: full))
}

#let render-resume(full: false) = {
  set document(title: profile.name + if full { " — Curriculum Vitae — Grotesk" } else { " — Resume — Grotesk" }, author: profile.name, date: none)
  show: cv.with(metadata, use-photo: false, left-pane: [], right-pane: [])
  set par(leading: 0.45em, spacing: 4pt)
  set list(indent: 8pt, body-indent: 3pt, spacing: 4pt, tight: true)
  set text(hyphenate: false)
  grid(columns: (1fr, 2.08in), column-gutter: 22pt,
    section("Experience", { for role in role-records(full: full) { entry(role) } }),
    sidebar(full: full),
  )
  if full {
    pagebreak()
    text(size: 22pt, weight: "bold", profile.name)
    linebreak()
    text(size: 11pt, fill: rgb("63636a"))[Selected work · Curriculum Vitae]
    section("Projects", { for project in project-records(full: true) { project-entry(project) } })
    section("Publications", [#link(publication.url, publication.title) #linebreak() #publication.credit])
  } else {
    section("Selected Projects", { for project in project-records() { project-entry(project) } })
  }
}
