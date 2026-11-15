import { appendFile, mkdir, writeFile } from "node:fs/promises";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { check, DEFAULT_POLICY, ENGINE_VERSION } from "@veriworkly/ats-engine";
import { US, withLocales } from "@veriworkly/ats-engine/locales";
import { readJobFile, readResumeFile } from "@veriworkly/ats-engine/node";

const policy = withLocales(DEFAULT_POLICY, { regions: [US] });
const root = dirname(dirname(fileURLToPath(import.meta.url)));
const disclaimer = "Advisory only: these are ATS Engine's heuristics, not an employer's ATS score. Review evidence before editing; never add unsupported qualifications.";
const date = process.env.ATS_REFERENCE_DATE ?? new Date().toISOString().slice(0, 10);
const now = new Date(`${date}T00:00:00Z`);

function summary(kind, report) {
  const details = [
    `## ${kind === "resume" ? "One-page resume" : "Two-page CV"}`,
    "",
    `Readiness: **${report.readinessScore}/100** · Checks passed: ${report.checksPassed}/${report.checksTotal}`,
  ];
  if (report.jobMatchScore !== null) {
    details.push(`Job match: **${report.jobMatchScore}/100**`, "",
      `Missing terms: ${report.missingKeywords.join(", ") || "None reported"}`);
  }
  details.push("", "### Findings", "");
  for (const finding of report.failedChecks) {
    details.push(`- **${finding.category} / ${finding.severity}:** ${finding.evidence} ${finding.fix}`);
  }
  if (!report.failedChecks.length) details.push("No findings reported.");
  if (report.parsingWarnings.length) {
    details.push("", "### Parsing warnings", "", ...report.parsingWarnings.map(w => `- ${w}`));
  }
  if (report.requirements.length) {
    details.push("", "### Job requirements", "");
    for (const requirement of report.requirements) {
      details.push(`- **${requirement.status}:** ${requirement.text}`);
      for (const evidence of requirement.evidence) details.push(`  - Evidence: ${evidence}`);
    }
  }
  details.push("", "See the JSON report for parsed roles, dates, education, skills, and all rule results.");
  return details.join("\n");
}

async function main() {
  if (process.argv.length > 3) throw new Error("Usage: node scripts/ats.mjs [path/to/job.txt]");
  if (!/^\d{4}-\d{2}-\d{2}$/.test(date) || !Number.isFinite(now.getTime()) || now.toISOString().slice(0, 10) !== date) {
    throw new Error("ATS_REFERENCE_DATE must be a valid YYYY-MM-DD date.");
  }
  const job = process.argv[2] ? await readJobFile(resolve(process.argv[2])) : null;
  if (job && !job.text.trim()) throw new Error("The job description is empty.");
  const mode = job ? "match" : "ats";
  const output = join(root, "dist", mode);
  await mkdir(output, { recursive: true });
  const sections = [`# Resume analysis`, "", disclaimer, "",
    `Engine: ${ENGINE_VERSION} · Reference date: ${date}`, ""];
  for (const kind of ["resume", "cv"]) {
    const pdf = join(root, "dist", `davis-schenkenberger-${kind}.pdf`);
    const { input, layout, file } = await readResumeFile(pdf);
    const report = check(input, policy, {
      layout, file, now, includeLines: true, languages: ["en"], region: "US",
      jobDescription: job?.text, jobCompany: job?.company,
    });
    await writeFile(join(output, `${kind}.json`), JSON.stringify({ referenceDate: date, disclaimer, ...report }, null, 2) + "\n");
    await writeFile(join(output, `${kind}-parsed.txt`), (report.lines ?? []).join("\n") + "\n");
    sections.push(summary(kind, report), "");
    console.log(`${kind}: advisory readiness ${report.readinessScore}/100${job ? `; job match ${report.jobMatchScore}/100` : ""}`);
  }
  const markdown = sections.join("\n");
  await writeFile(join(output, "report.md"), markdown);
  if (process.env.GITHUB_STEP_SUMMARY) await appendFile(process.env.GITHUB_STEP_SUMMARY, markdown + "\n");
  console.log(`Reports saved to dist/${mode}/. ${disclaimer}`);
}

main().catch(error => {
  console.error(`ATS analysis failed: ${error.message}`);
  process.exitCode = 1;
});
