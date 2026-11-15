"""Build both documents with the pinned compiler and repository fonts."""

from pathlib import Path
import shutil
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]


def main():
    compiler = shutil.which("typst")
    if not compiler:
        sys.exit("Typst is missing. Install the version in .typst-version; see README.md.")
    expected = (ROOT / ".typst-version").read_text().strip()
    actual = subprocess.check_output([compiler, "--version"], text=True).split()[1]
    if actual != expected:
        sys.exit(f"Expected Typst {expected}, found {actual}.")
    output = ROOT / "dist"
    output.mkdir(exist_ok=True)
    for source, name in (("resume", "resume"), ("cv", "cv")):
        subprocess.run(
            [compiler, "compile", "--root", str(ROOT), "--ignore-system-fonts",
             "--font-path", str(ROOT / "fonts"), str(ROOT / f"{source}.typ"),
             str(output / f"davis-schenkenberger-{name}.pdf")],
            check=True,
        )


if __name__ == "__main__":
    main()
