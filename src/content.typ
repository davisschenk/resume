#let profile = (
  name: "Davis Schenkenberger",
  headline: "Software Development & Test Automation",
  email: "davis.schenkenberger@gmail.com",
  location: "Fort Collins, Colorado",
  github: "https://github.com/davisschenk",
  linkedin: "https://www.linkedin.com/in/davis-schenkenberger-686a02157/",
)

#let skills = (
  (label: "Software", text: "Python, Rust, C++, Java, Git, Bash, Linux"),
  (label: "Testing", text: "Pytest, Playwright, Selenium, TestRail API, Page Object Model"),
  (label: "Data & systems", text: "Pandas, Polars, NumPy, GeoPandas, ArcPy, ArduPilot, MAVLink"),
)

#let experience = (
  automation: (
    title: "Flight Test Automation", organization: "Skydio",
    dates: "February 2026–Present", location: "Fort Collins, Colorado",
    bullets: (),
  ),
  operator: (
    title: "Flight Test Operator", organization: "Skydio",
    dates: "January 2025–February 2026", location: "Fort Collins, Colorado",
    bullets: (
      "Designed automated test workflows with Pytest and Playwright to reduce manual testing workload.",
      "Developed internal tools to support flight safety, airspace deconfliction, and operator efficiency.",
      "Executed recurring smoke and sanity tests; collaborated with engineers to document and troubleshoot system bugs.",
      "Conducted flight operations in accordance with FAA regulations and internal safety protocols.",
    ),
  ),
  drone: (
    title: "UAV Technician", organization: "CSU Drone Center",
    dates: "January 2021–January 2025", location: "Fort Collins, Colorado",
    bullets: (
      "Developed Python workflows for data management and processing across research and engineering projects.",
      "Integrated mapping sensors and conducted UAS flight testing to assess system performance and software stability.",
      "Served as Remote Pilot in Command; developed and taught Part 107 and mapping/modeling course material.",
      "Assisted with planning and hosting the 2023 Colorado Drone Airshow.",
    ),
  ),
  agriculture: (
    title: "Precision Agriculture Research Assistant",
    organization: "CSU Department of Agricultural Biology",
    dates: "January 2024–January 2025", location: "Fort Collins, Colorado",
    bullets: (
      "Developed automated hyperspectral data-processing workflows and processed terabytes of research data.",
      "Led UAV operations for the Hyperspectral AI Lab using a Hercules X8 with a HySpex VS-1240 sensor.",
      "Trained team members in drone and sensor operation while maintaining safe, FAA-compliant missions.",
    ),
  ),
  gis: (
    title: "GIS Analyst", organization: "CSU Department of Biology",
    dates: "November 2022–May 2023", location: "Fort Collins, Colorado",
    bullets: (
      "Analyzed methane-emissions datasets with ArcGIS Pro and Python (ArcPy).",
      "Automated processing for reproducible analysis and created visualizations and reports for stakeholders.",
    ),
  ),
)

#let projects = (
  regression: (
    title: "Inspection & Mapping Test Automation", organization: "Skydio",
    dates: "Started April 2025", technology: "Python · Playwright · Pytest · TestRail",
    bullets: (
      "Built a regression and integration framework using the Page Object Model for reusable, maintainable tests.",
      "Integrated TestRail API reporting through a custom Pytest plugin and automated authentication to reduce manual intervention.",
    ),
    url: none,
  ),
  ardupilot: (
    title: "LORD AHRS Integration with ArduPilot", organization: "CSU Drone Center",
    dates: "June–October 2021", technology: "C++ · Embedded systems · Flight testing",
    bullets: (
      "Integrated a LORD 3DM-series attitude and heading reference sensor with ArduPilot; tested across flight platforms and built an ArduPilot-based quadcopter.",
    ),
    url: "https://github.com/ArduPilot/ardupilot/pull/18837",
  ),
  sensor: (
    title: "Methane Emissions Sensor", organization: "Colorado State University",
    dates: "March–July 2024", technology: "Python · Rust · MAVLink",
    bullets: (
      "Developed UAS-based methane sensor software with MAVLink integration to transmit measurements over the drone radio link.",
    ),
    url: "https://github.com/davisschenk/metec-sensor",
  ),
  connect: (
    title: "Networked Connect Four", organization: "Colorado State University",
    dates: "September–December 2024", technology: "Python · Networking · Unit testing · CI/CD",
    bullets: ("Implemented a Python Connect Four game supporting multiple clients.",),
    url: "https://github.com/davisschenk/connect-four",
  ),
  methane: (
    title: "Methane Emission Analysis", organization: "Colorado State University",
    dates: "November–December 2022", technology: "Python · ArcGIS Pro · ArcPy",
    bullets: (
      "Analyzed hundreds of gigabytes of vehicle-collected methane data against wetland types and EDGAR emissions data; developed automated sensor measurement and reporting software.",
    ),
    url: "https://source.colostate.edu/google-street-view-cars-eyes-ground-urban-methane-leaks/",
  ),
  coal: (
    title: "Coal Basin Methane Emissions", organization: "Colorado State University",
    dates: "July 2022", technology: "UAS mapping · Thermal imaging",
    bullets: (
      "Led UAS thermal-imaging and mapping operations for methane detection in mountainous terrain while adhering to FAA regulations.",
    ),
    url: none,
  ),
)

#let education = (
  degree: "B.Sc. in Computer Science", school: "Colorado State University",
  dates: "August 2020–December 2024", graduated: "December 2024",
)

#let certifications = (
  (name: "Part 107 Commercial Drone Pilot", issuer: "FAA", date: "October 2021"),
  (name: "Skydio Dock Certified", issuer: "Skydio", date: "March 2024"),
  (name: "HySpex Hyperspectral Drone Operator", issuer: "HySpex", date: "February 2024"),
  (name: "Wingtra GEN II Trainer", issuer: "Wingtra", date: "December 2023"),
  (name: "Wingtra GEN II Basic & Advanced Operator", issuer: "Wingtra", date: "November 2023"),
)

#let publication = (
  title: "LORD IMU Integration with Ardupilot",
  credit: "Davis Schenkenberger et al. · Parker LORD · July 2021 · Technical white paper",
  url: "https://www.microstrain.com/sites/default/files/white_paper_final_formatted_2_0.pdf",
)
