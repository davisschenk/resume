#import "../content.typ": profile, skills, experience, projects, education, certifications, publication

#let contact = [
  #profile.location · #link("mailto:" + profile.email, profile.email)
  #linebreak()
  #link(profile.github)[github.com/davisschenk] · #link(profile.linkedin)[LinkedIn]
]

#let role-records(full: false) = (
  experience.automation,
  experience.operator + (bullets: experience.operator.bullets.slice(0, 2),),
  experience.drone + (bullets: experience.drone.bullets.slice(0, if full { 4 } else { 2 }),),
  experience.agriculture + (bullets: experience.agriculture.bullets.slice(0, if full { 3 } else { 1 }),),
) + if full { (experience.gis,) } else { () }

#let project-records(full: false) = if full {
  (projects.regression, projects.sensor, projects.ardupilot, projects.connect, projects.methane, projects.coal)
} else {
  (projects.regression, projects.ardupilot)
}

#let credentials(full: false, inline: false) = {
  for cert in if full { certifications } else { (certifications.at(0),) } {
    block(above: 7pt, below: 5pt)[
      #text(weight: "bold", cert.name)
      #if inline { [ · ] } else { linebreak() }
      #cert.issuer · Issued #cert.date
    ]
  }
}

#let degree = [
  #text(weight: "bold", education.degree)
  #linebreak()
  #education.school
  #linebreak()
  Graduated #education.graduated
]
