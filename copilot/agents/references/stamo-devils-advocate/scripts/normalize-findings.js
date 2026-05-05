#!/usr/bin/env node
/**
 * normalize-findings.js
 * Usage:
 *   node .github/skills/blazor-devils-advocate/scripts/normalize-findings.js --input "<raw.json>" --output "<normalized.json>"
 */

const fs = require('fs');
const path = require('path');
const { parseArgs } = require('util');

const USAGE = 'Usage: node .github/skills/blazor-devils-advocate/scripts/normalize-findings.js --input "<raw.json>" --output "<normalized.json>"';
const severityRank = { critical: 0, warning: 1, advisory: 2 };

function fail(message) {
    process.stderr.write(`ERROR: ${message}\n${USAGE}\n`);
    process.exit(1);
}

function normalizeString(value) {
    return String(value || '').trim();
}

function normalizeSeverity(value) {
    const s = normalizeString(value).toLowerCase();
    if (s.includes('critical')) return 'critical';
    if (s.includes('warning')) return 'warning';
    if (s.includes('advisory')) return 'advisory';
    return null;
}

let values;
try {
    ({ values } = parseArgs({
        options: {
            input: { type: 'string' },
            output: { type: 'string' },
        },
    }));
} catch {
    fail('Failed to parse arguments. Expected --input and --output.');
}

const inputPath = values.input;
const outputPath = values.output;

if (!inputPath || !outputPath) {
    fail('Both --input and --output are required.');
}

if (!fs.existsSync(inputPath)) {
    fail(`Input file not found: ${inputPath}`);
}

let raw;
try {
    raw = fs.readFileSync(inputPath, 'utf8');
} catch {
    fail(`Cannot read input file: ${inputPath}`);
}

let parsed;
try {
    parsed = JSON.parse(raw);
} catch {
    fail('Input file is not valid JSON.');
}

if (!Array.isArray(parsed)) {
    fail('Input JSON must be an array of finding objects.');
}

const normalized = [];
const seen = new Set();
const skipped = [];

for (const item of parsed) {
    const severity = normalizeSeverity(item?.severity);
    const title = normalizeString(item?.title);
    const location = normalizeString(item?.location) || 'n/a';
    const explanation = normalizeString(item?.explanation);
    const suggestedFix = normalizeString(item?.suggestedFix);

    if (!severity || !title || !explanation) {
        const reason = !severity ? 'invalid severity' : !title ? 'missing title' : 'missing explanation';
        process.stderr.write(`SKIPPED: Entry dropped — ${reason}: ${JSON.stringify(item)}\n`);
        skipped.push(item);
        continue;
    }

    const dedupeKey = `${severity}|${title.toLowerCase()}|${location.toLowerCase()}|${explanation.toLowerCase()}`;
    if (seen.has(dedupeKey)) {
        continue;
    }

    seen.add(dedupeKey);
    normalized.push({
        severity,
        title,
        location,
        explanation,
        ...(suggestedFix ? { suggestedFix } : {}),
    });
}

normalized.sort((a, b) => {
    const sevDiff = severityRank[a.severity] - severityRank[b.severity];
    if (sevDiff !== 0) {
        return sevDiff;
    }

    const titleDiff = a.title.localeCompare(b.title, 'en', { sensitivity: 'base' });
    if (titleDiff !== 0) {
        return titleDiff;
    }

    return a.location.localeCompare(b.location, 'en', { sensitivity: 'base' });
});

try {
    fs.mkdirSync(path.dirname(outputPath), { recursive: true });
    fs.writeFileSync(outputPath, `${JSON.stringify(normalized, null, 2)}\n`, 'utf8');
} catch {
    fail(`Cannot write output file: ${outputPath}`);
}

process.stdout.write(`SUCCESS: Normalized ${normalized.length} findings.\n`);
if (skipped.length > 0) {
    process.stderr.write(`WARNING: ${skipped.length} entr${skipped.length === 1 ? 'y was' : 'ies were'} skipped due to missing or invalid fields. See SKIPPED lines above.\n`);
    process.exit(2);
}
