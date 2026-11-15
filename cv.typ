#import "src/content.typ": profile, skills, experience, projects, education, certifications, publication
#import "src/layout.typ": document-layout, header, job, project, skill-lines
#show: document-layout.with(kind: "Curriculum Vitae")
#set page(footer: context [#text(size: 10pt, fill: rgb("495461"))[#profile.name · Curriculum Vitae] #h(1fr) #counter(page).display("1 / 1", both: true)])

#header()

= Technical Skills
#skill-lines(skills)

= Professional Experience
#job(experience.automation)
#job(experience.operator)
#job(experience.drone)
#job(experience.agriculture)
#job(experience.gis)

= Education
#text(weight: "bold")[#education.degree] · #education.school #h(1fr) #education.dates

= Certifications
#for cert in certifications [
  #text(weight: "bold")[#cert.name] · #cert.issuer #h(1fr) Issued #cert.date #linebreak()
]

#pagebreak()
= Projects
#project(projects.regression)
#project(projects.sensor)
#project(projects.ardupilot)
#project(projects.connect)
#project(projects.methane)
#project(projects.coal)

= Publications
#link(publication.url)[#text(weight: "bold", publication.title)]
#linebreak()
#publication.credit
