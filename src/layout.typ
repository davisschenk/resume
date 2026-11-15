#import "content.typ": profile

#let navy = rgb("19354b")
#let muted = rgb("495461")

#let document-layout(kind: "Resume", body) = {
  set document(title: profile.name + " — " + kind, author: profile.name, date: none)
  set page(paper: "us-letter", margin: (x: 0.6in, y: 0.48in))
  set text(font: "Libertinus Sans", size: 11pt, lang: "en", fill: rgb("202a33"))
  set par(leading: 0.7em, spacing: 0.5em)
  set list(indent: 10pt, body-indent: 4pt, spacing: 4pt, tight: false)
  set heading(numbering: none)
  show heading.where(level: 1): it => block(above: 11pt, below: 6pt)[
    #stack(spacing: 4pt,
      text(size: 11pt, weight: "bold", fill: navy, upper(it.body)),
      line(length: 100%, stroke: 0.4pt + rgb("c7d0d8")),
    )
  ]
  show link: it => text(fill: navy, it)
  body
}

#let header(compact: false) = {
  text(size: if compact { 24pt } else { 27pt }, weight: "bold", fill: navy, profile.name)
  v(3pt)
  text(size: 11pt, fill: muted, profile.headline)
  v(5pt)
  text(size: 10pt)[#profile.location #h(7pt) #link("mailto:" + profile.email)[#profile.email]]
  linebreak()
  text(size: 10pt)[#link(profile.github)[github.com/davisschenk] #h(7pt) #link(profile.linkedin)[LinkedIn: Davis Schenkenberger]]
}

#let bullet-list(items) = {
  if items.len() > 0 { list(..items) }
}

#let job(record, selected: none) = block(breakable: false, above: 9pt, below: 4pt)[
  #text(weight: "bold")[#record.title] #h(1fr) #text(size: 10pt, fill: muted, record.dates)
  #linebreak()
  #text(fill: navy, record.organization)
  #bullet-list(if selected == none { record.bullets } else { selected.map(i => record.bullets.at(i)) })
]

#let project(record) = block(breakable: false, above: 9pt, below: 4pt)[
  #text(weight: "bold")[#if record.url != none { link(record.url, record.title) } else { record.title }] #h(1fr) #text(size: 10pt, fill: muted, record.dates)
  #linebreak()
  #text(fill: muted)[#record.organization · #record.technology]
  #bullet-list(record.bullets)
]

#let skill-lines(groups) = {
  for group in groups [
    #text(weight: "bold")[#group.label:] #group.text #linebreak()
  ]
}
