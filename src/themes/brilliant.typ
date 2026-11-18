#import "../vendor/brilliant-cv/src/lib.typ": cv, cv-section, cv-entry
#import "common.typ": *
#let metadata = toml("brilliant.toml")

#let entry(record) = cv-entry(
  title: record.title, society: record.organization, date: record.dates,
  location: "", description: list(..record.bullets),
)
#let project-entry(record) = cv-entry(
  title: if record.url != none { link(record.url, record.title) } else { record.title },
  society: record.technology, date: record.dates,
  location: "", description: list(..record.bullets),
)

#let render-resume(full: false) = {
  set document(title: profile.name + if full { " — Curriculum Vitae — Brilliant" } else { " — Resume — Brilliant" }, author: profile.name, date: none)
  show: cv.with(metadata, header-info: contact)
  set text(hyphenate: false)
  set par(leading: 0.45em, spacing: 4pt)
  set list(indent: 9pt, body-indent: 3pt, spacing: 3pt)
  cv-section("Technical Skills")
  for group in skills [#text(weight: "bold")[#group.label:] #group.text #linebreak()]
  cv-section("Experience")
  for role in role-records(full: full) { entry(role) }
  if full { pagebreak() }
  cv-section("Projects")
  for project in project-records(full: full) { project-entry(project) }
  cv-section("Certifications")
  credentials(full: full, inline: true)
  cv-section("Education")
  degree
  if full { cv-section("Publications"); link(publication.url, publication.title); linebreak(); publication.credit }
}
