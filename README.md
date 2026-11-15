# Davis Schenkenberger — Resume

A one-page resume and a detailed two-page CV focused on software development,
test automation, and flight-test experience. Both are built from shared content
with Typst, using US Letter pages and selectable text.

## Downloads

After the first merge, every successful build on `master` updates the
[`latest` prerelease](https://github.com/davisschenk/resume/releases/tag/latest):

- [One-page resume](https://github.com/davisschenk/resume/releases/download/latest/davis-schenkenberger-resume.pdf)
- [Two-page CV](https://github.com/davisschenk/resume/releases/download/latest/davis-schenkenberger-cv.pdf)

Pull requests provide PDF and rendered-preview artifacts in the **Build resume
PDFs** Actions run. They never publish a release. Generated files are not committed.

## Build locally

Install [Typst 0.15.1](https://github.com/typst/typst/releases/tag/v0.15.1),
[just](https://github.com/casey/just), and Python 3.12 or newer. The build refuses
other Typst versions; `.typst-version` records the required version.

```sh
python3 -m venv .venv
. .venv/bin/activate
python3 -m pip install -r scripts/requirements.txt
just check
```

On Windows, activate with `.venv\Scripts\Activate.ps1` in PowerShell. Run the
Python commands below directly if Bash/just is unavailable.

| Command | Result |
| --- | --- |
| `just build` | Build both PDFs into `dist/` |
| `just check` | Build, validate, and render page previews into `dist/` |
| `just clean` | Remove `dist/` |

The equivalent commands without just are `python3 scripts/build.py` and
`python3 scripts/check.py` (run build before check). On Windows, use `python`
if that is the installed interpreter command.

Validation checks page counts, US Letter size, required content, experience
ordering, excluded personal details, link annotations, metadata, minimum font
size, and text bounds. It also writes extracted text and PNGs for visual review.
It does not guarantee compatibility with every applicant tracking system.

## ATS checks and job matching

The optional ATS workflow uses [ATS Engine](https://github.com/VeriWorkly/ats-engine)
0.22.0 (MIT), with a second PDF extraction engine independent of our PyMuPDF
checks. It runs locally without an API key, AI provider, or resume upload. Installing
dependencies requires access to npm; analysis of local files does not.

Install Node.js 22.22.0 (recorded in `.nvmrc`), then:

```sh
npm ci --ignore-scripts
just ats
just match jobs/example.txt
npm test
```

`just ats` builds both PDFs and writes `dist/ats/report.md`, per-document JSON
reports, and extracted text. `just match` builds both PDFs and writes the same
reports, with job matching, under `dist/match/`. Each successful run overwrites
that mode's previous reports. `npm test` verifies the generated ATS and example
match reports, including role dates and certification parsing; generate both
reports with the commands above before running it.

`jobs/example.txt` is an illustrative posting to exercise matching, not a real
vacancy. For an actual application, save the posting as `.txt` or `.md` under
`jobs/local/` (ignored by Git), then run:

```sh
just match jobs/local/automation-engineer.txt
```

Quote paths containing spaces. Without just, run `python3 scripts/build.py`, then
`npm run ats` or `npm run match -- jobs/local/automation-engineer.txt`.
Use `python` instead of `python3` where appropriate on Windows.

Readiness and job-match scores are advisory heuristics, not scores from an
employer's ATS or predictions of an interview. Inspect the parsed fields,
requirement evidence, and warnings before editing. Do not add unsupported skills
or metrics to increase a score. The tool can misinterpret relevance or evidence;
its claimed matches still need human review.

Reports record the engine/policy versions and reference date. The date defaults
to today's UTC date because current-role tenure changes over time. To reproduce
a prior run, set `ATS_REFERENCE_DATE=YYYY-MM-DD` before invoking the command.
Keep the npm lockfile committed; use `npm ci` for reproducible dependencies.

A separate, non-blocking Actions job analyzes the validated PDF artifacts, tests
matching against the illustrative posting, and uploads `resume-ats-reports`.
Scores do not fail a build, and ATS job failures do not block PDF publishing.
Actual extraction errors still return a nonzero exit status locally. Existing
PDF validation remains required. Job descriptions and parsed resume text may
appear in reports; public CI analyzes only the committed example posting.

## Edit the documents

- `src/content.typ` owns contact details, skills, roles, project achievements,
  education, credentials, and publication information.
- `resume.typ` selects a concise subset of that content. `cv.typ` includes the
  fuller work history, projects, certifications, and technical publication.
- `src/layout.typ` owns shared typography, spacing, headings, and reusable entries.

Edit facts once in the shared content module, then adjust selections in the
entrypoints. Run `just check` and inspect every generated PNG before submitting
changes. Keep the resume at one page and the CV at two; favor concise wording
over reducing body text below 10 pt. Body text currently uses 11 pt.

The Skydio title progression comes from the supplied LinkedIn screenshot. Earlier
responsibilities and dated projects come from the updated resume attachment;
the current automation role deliberately has no inferred responsibilities.
Certification dates are issue dates, not assertions of current validity. The
LORD/ArduPilot publication is labeled as a technical white paper.

Contact information is limited to email, city, and public profiles. The old
Org-mode/AltaCV sources, portrait, and application-specific cover letter remain
available in Git history, but are no longer part of the build. No history was
rewritten.

## Automation and dependencies

GitHub Actions uses Python 3.12, the same pinned Typst compiler and validation
scripts, and repository-local fonts. Typst's Linux archive is checksum-verified;
Actions dependencies are pinned to commits. Pull requests have read-only
repository permissions. A separate publishing job runs only after a successful
push build on `master` and updates the moving `latest` tag and prerelease assets.

To upgrade Typst, update `.typst-version` and the archive checksum in the workflow
together, then rebuild and visually review both documents. Validation dependencies
are pinned in `scripts/requirements.txt`.

Libertinus Sans 7.051 (regular, bold, italic) is bundled in `fonts/` under the
[SIL Open Font License](fonts/OFL.txt). Builds ignore system fonts and use no
external Typst packages. See [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).
