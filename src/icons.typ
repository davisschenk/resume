#let paths = (
  pin: "<path d='M12 22s7-6 7-13a7 7 0 0 0-14 0c0 7 7 13 7 13Z'/><circle cx='12' cy='9' r='2.5'/>",
  mail: "<path d='m2 10 20-7-6 18-5-7-9-4Zm9 4 11-11'/>",
  code: "<path d='m8 6-6 6 6 6m8-12 6 6-6 6m-2-15-4 18'/>",
  link: "<path d='M10 13a4 4 0 0 0 6 0l4-4a4 4 0 0 0-6-6l-2 2m2 6a4 4 0 0 0-6 0l-4 4a4 4 0 0 0 6 6l2-2'/>",
  skills: "<path d='M4 19V13m5 6V8m6 11V5m5 14V3'/>",
  work: "<path d='M3 9q0-2 2-2h14q2 0 2 2v9q0 2-2 2H5q-2 0-2-2V9Zm5-2V5q0-2 2-2h4q2 0 2 2v2M3 11q9 8 18 0m-9 3v3'/>",
  projects: "<path d='m12 2 9 5v10l-9 5-9-5V7l9-5Zm-9 5 9 5 9-5m-9 5v10'/>",
  certificate: "<path d='m12 2 2.6 2.8 3.8.6.6 3.8 2.8 2.6-2.8 2.6-.6 3.8-3.8.6-2.6 2.8-2.6-2.8-3.8-.6-.6-3.8-2.8-2.6L5 9.2l.6-3.8 3.8-.6L12 2Zm-4 10 2.7 2.7L16 9.4'/>",
  education: "<path d='m2 9 10-5 10 5-10 5-10-5Zm4 2v5c4 3 8 3 12 0v-5m4-2v7'/>",
  publication: "<path d='M3 5c4-2 7-1 9 1 2-2 5-3 9-1v13c-4-2-7-1-9 1-2-2-5-3-9-1V5Zm9 1v13'/>",
)

#let icon(name, color, size: 10pt) = pdf.artifact(image(
  bytes("<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='"
    + color.to-hex() + "' stroke-width='1.7' stroke-linecap='round' stroke-linejoin='round'>"
    + paths.at(name) + "</svg>"),
  format: "svg",
  width: size,
  height: size,
))
