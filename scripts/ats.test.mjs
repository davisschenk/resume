import assert from "node:assert/strict";
import { spawnSync } from "node:child_process";
import { readFile } from "node:fs/promises";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";
import test from "node:test";

const root = dirname(dirname(fileURLToPath(import.meta.url)));
const report = async (mode, kind) => JSON.parse(await readFile(join(root, "dist", mode, `${kind}.json`), "utf8"));

for (const [kind, count] of [["resume", 1], ["cv", 5]]) {
  test(`${kind}: parser preserves role progression and separates credentials from projects`, async () => {
    const { parsed, rules } = await report("ats", kind);
    for (const id of ["ats-v2.format.columns", "ats-v2.format.tables"]) {
      assert.equal(rules.find(rule => rule.id === id)?.passed, true, id);
    }
    const [current, previous] = parsed.roles;
    assert.equal(current.title, "Flight Test Automation");
    assert.equal(current.employer, "Skydio");
    assert.deepEqual(current.start, { year: 2026, month: 2 });
    assert.equal(current.current, true);
    assert.equal(previous.title, "Flight Test Operator");
    assert.deepEqual(previous.start, { year: 2025, month: 1 });
    assert.deepEqual(previous.end, { year: 2026, month: 2 });
    assert.equal(parsed.education[0].school, "Colorado State University");
    assert.equal(parsed.education[0].isced, 6);
    assert.equal(parsed.certifications.length, count);
    assert.ok(parsed.certifications.some(c => c.name === "Part 107 Commercial Drone Pilot"));
  });

  test(`${kind}: scores remain advisory and the example job produces evidence`, async () => {
    const ats = await report("ats", kind);
    const match = await report("match", kind);
    assert.equal(ats.jobMatchScore, null);
    assert.equal(typeof match.jobMatchScore, "number");
    assert.ok(match.requirements.length > 0);
    assert.ok(match.requirements.some(r => r.evidence.length > 0));
    assert.equal(typeof ats.readinessScore, "number");
    assert.match(ats.disclaimer, /Advisory only/);
    assert.equal(match.engine.version, "0.22.0");
  });
}

test("missing posting and invalid reference date fail with useful messages", () => {
  const missing = spawnSync(process.execPath, ["scripts/ats.mjs", "jobs/does-not-exist.txt"], { cwd: root, encoding: "utf8" });
  assert.equal(missing.status, 1);
  assert.match(missing.stderr, /ATS analysis failed/);
  const invalid = spawnSync(process.execPath, ["scripts/ats.mjs"], {
    cwd: root, encoding: "utf8", env: { ...process.env, ATS_REFERENCE_DATE: "2026-02-30" },
  });
  assert.equal(invalid.status, 1);
  assert.match(invalid.stderr, /valid YYYY-MM-DD/);
});
