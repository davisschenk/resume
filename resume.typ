#import "src/content.typ": profile, skills, experience, projects, education, certifications
#import "src/layout.typ": document-layout, header, job, project, skill-lines
#show: document-layout.with(kind: "Resume")

#header(compact: true)

= Technical Skills
#skill-lines(skills)

= Experience
#job(experience.automation)
#job(experience.operator, selected: (0, 1))
#job(experience.drone, selected: (0, 1))
#job(experience.agriculture, selected: (0,))

= Projects
#project(projects.regression)
#project(projects.ardupilot)

= Certifications
#certifications.at(0).name · #certifications.at(0).issuer · Issued #certifications.at(0).date

= Education
#text(weight: "bold")[#education.degree] · #education.school #h(1fr) #education.graduated
