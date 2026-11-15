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
