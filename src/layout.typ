#import "content.typ": profile
#import "icons.typ": icon

#let navy = rgb("142d43")
#let teal = rgb("17685f")
#let muted = rgb("47586a")
#let wash = rgb("eef5f5")
#let rule = rgb("cbdcdd")

#let section-icons = (
  "Technical Skills": "skills",
  "Experience": "work",
  "Professional Experience": "work",
  "Projects": "projects",
  "Certifications": "certificate",
  "Education": "education",
  "Publications": "publication",
)

#let document-layout(kind: "Resume", body) = {
  set document(title: profile.name + " — " + kind, author: profile.name, date: none)
  set page(paper: "us-letter", margin: (x: 0.6in, y: 0.48in))
  set text(font: "Libertinus Sans", size: 11pt, lang: "en", fill: rgb("202a33"))
  set par(leading: 0.7em, spacing: 0.5em)
  set list(indent: 10pt, body-indent: 4pt, spacing: 4pt, tight: false)
  set heading(numbering: none)
  show heading.where(level: 1): it => {
    let mark = section-icons.at(it.body.fields().at("text", default: ""), default: none)
    block(above: 12pt, below: 5pt, sticky: true)[
      #if mark != none {
        box(baseline: 5pt, inset: 4pt, radius: 3pt, fill: wash, icon(mark, teal))
        h(6pt)
      }
      #text(font: "Libertinus Serif", size: 14pt, weight: "bold", fill: navy, it.body)
      #h(9pt)#box(width: 1fr, baseline: 3pt, line(length: 100%, stroke: 0.6pt + rule))
    ]
  }
  show link: it => text(fill: navy, it)
  body
}

#let contact(mark, value) = box[
  #box(baseline: 1.5pt, icon(mark, teal))#h(4pt)#text(size: 10pt, fill: muted, value)
]

#let header(compact: false) = block(
  width: 100%,
  inset: (left: 15pt, right: 13pt, top: 12pt, bottom: 12pt),
  fill: wash,
  stroke: (left: 3pt + teal),
)[
  #text(
    font: "Libertinus Serif",
    size: if compact { 32pt } else { 34pt },
    weight: "bold",
    fill: navy,
    profile.name,
  )
  #v(3pt)
  #text(size: 12pt, weight: "bold", fill: teal, profile.headline)
  #v(7pt)
  #contact("pin", profile.location)#h(15pt)#contact("mail", link("mailto:" + profile.email, profile.email))
  #linebreak()
  #contact("code", link(profile.github)[github.com/davisschenk])#h(15pt)#contact("link", link(profile.linkedin)[LinkedIn: Davis Schenkenberger])
]

#let bullet-list(items) = {
  if items.len() > 0 { list(..items) }
}

#let job(record, selected: none) = block(breakable: false, above: 9pt, below: 4pt)[
  #text(weight: "bold")[#record.title] #h(1fr) #text(size: 10pt, fill: teal, record.dates)
  #linebreak()
  #text(weight: "bold", fill: teal, record.organization)
  #bullet-list(if selected == none { record.bullets } else { selected.map(i => record.bullets.at(i)) })
]

#let project(record) = block(breakable: false, above: 9pt, below: 4pt)[
  #text(weight: "bold")[#if record.url != none { link(record.url, record.title) } else { record.title }] #h(1fr) #text(size: 10pt, fill: teal, record.dates)
  #linebreak()
  #text(fill: muted)[#record.organization · #record.technology]
  #bullet-list(record.bullets)
]

#let skill-lines(groups) = {
  for group in groups [
    #text(weight: "bold", fill: teal)[#group.label:] #group.text #linebreak()
  ]
}
