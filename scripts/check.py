"""Check the documents as PDFs, including extracted text and link annotations."""

from pathlib import Path
import re
import sys

try:
    import pymupdf
except ImportError:
    sys.exit("Install validation dependencies: python3 -m pip install -r scripts/requirements.txt")

ROOT = Path(__file__).resolve().parents[1]


def require(condition, message):
    if not condition:
        sys.exit(message)


def normalize(text):
    return re.sub(r"\s+", " ", text).replace("–", "-").replace("—", "-")


def main():
    documents = (("resume", 1), ("cv", 2))
    if "--themes" in sys.argv:
        documents += (("resume-grotesk", 1), ("cv-grotesk", 2),
                      ("resume-brilliant", 1), ("cv-brilliant", 2))
    for kind, pages in documents:
        path = ROOT / "dist" / f"davis-schenkenberger-{kind}.pdf"
        with pymupdf.open(path) as doc:
            require(len(doc) == pages, f"{kind}: expected {pages} pages, got {len(doc)}")
            text = normalize(" ".join(page.get_text(sort=False) for page in doc))
            expected = (
                "Davis Schenkenberger", "Flight Test Automation", "February 2026-Present",
                "Flight Test Operator", "January 2025-February 2026", "Playwright", "Pytest",
                "TestRail", "Appium", "Databricks", "checkout on master", "April 2025",
                "Computer Science", "December 2024", "ArduPilot",
            )
            for phrase in expected:
                require(phrase in text, f"{kind}: missing {phrase!r}")
            titles = ("Flight Test Automation", "Flight Test Operator", "UAV Technician",
                      "Precision Agriculture Research Assistant")
            positions = [text.index(title) for title in titles]
            require(positions == sorted(positions), f"{kind}: experience text is out of order")
            excluded = ("970", "@colostate.edu", "@rams.colostate.edu", "References",
                        "Dear Hiring", "76 manual", "G47", "davisschenk@gmail.com")
            for phrase in excluded:
                require(phrase not in text, f"{kind}: excluded content {phrase!r}")
            uris = {link.get("uri", "") for page in doc for link in page.get_links()}
            for uri in (
                "mailto:davis.schenkenberger@gmail.com", "https://github.com/davisschenk",
                "https://www.linkedin.com/in/davis-schenkenberger-686a02157/",
                "https://github.com/ArduPilot/ardupilot/pull/18837",
            ):
                require(uri in uris, f"{kind}: missing PDF link {uri}")
            require(doc.metadata.get("author") == "Davis Schenkenberger", f"{kind}: wrong author")
            require("Davis Schenkenberger" in doc.metadata.get("title", ""), f"{kind}: missing title")
            for page in doc:
                require(abs(page.rect.width - 612) < 1 and abs(page.rect.height - 792) < 1,
                        f"{kind}: expected US Letter")
                for block in page.get_text("dict")["blocks"]:
                    for line in block.get("lines", []):
                        for span in line["spans"]:
                            require(span["size"] >= 9.99, f"{kind}: text below 10 pt")
                            require(page.rect.contains(pymupdf.Rect(span["bbox"])),
                                    f"{kind}: text extends beyond page")
                image_path = ROOT / "dist" / f"{kind}-page-{page.number + 1}.png"
                page.get_pixmap(matrix=pymupdf.Matrix(1.5, 1.5)).save(image_path)
            if kind.startswith("cv"):
                for phrase in ("Wingtra GEN II Trainer", "Wingtra GEN II Basic & Advanced Operator",
                               "Technical white paper", "GIS Analyst", "Networked Connect Four"):
                    require(phrase in text, f"cv: missing {phrase!r}")
            (ROOT / "dist" / f"{kind}.txt").write_text(text + "\n")
            print(f"{path.name}: {pages} pages; text, links, metadata, and layout checks passed")


if __name__ == "__main__":
    main()
