set shell := ["bash", "-eu", "-o", "pipefail", "-c"]

default:
    @just --list

build:
    python3 scripts/build.py

check: build
    python3 scripts/check.py

clean:
    rm -rf dist

ats: build
    node scripts/ats.mjs

match job: build
    node scripts/ats.mjs {{quote(job)}}
