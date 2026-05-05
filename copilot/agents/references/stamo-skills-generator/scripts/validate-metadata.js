#!/usr/bin/env node
/**
 * validate-metadata.js
 * Usage: node scripts/validate-metadata.js --name "<name>" --description "<description>"
 *
 * Validates the skill metadata (name and description) against the agentskills.io spec.
 *
 * Exit codes:
 *   0 — metadata is valid
 *   1 — metadata is invalid (details printed to stderr)
 */

const { parseArgs } = require('util');

// ---------------------------------------------------------------------------
// Argument parsing
// ---------------------------------------------------------------------------
let values;
try {
    ({ values } = parseArgs({
        options: {
            name:        { type: 'string' },
            description: { type: 'string' },
        },
    }));
} catch {
    process.stderr.write('ERROR: Failed to parse arguments.\n');
    process.stderr.write('Usage: node scripts/validate-metadata.js --name "<name>" --description "<description>"\n');
    process.exit(1);
}

const { name, description } = values;

if (!name || !description) {
    process.stderr.write('ERROR: Both --name and --description are required.\n');
    process.stderr.write('Usage: node scripts/validate-metadata.js --name "<name>" --description "<description>"\n');
    process.exit(1);
}

// ---------------------------------------------------------------------------
// Validation
// ---------------------------------------------------------------------------
const errors = [];

// 1. Validate name length (1–64 characters)
if (name.length < 1 || name.length > 64) {
    errors.push(
        `NAME ERROR: '${name}' is ${name.length} characters. Must be between 1-64.`
    );
}

// 2. Validate name characters (lowercase letters, numbers, single hyphens;
//    cannot start or end with a hyphen; no consecutive hyphens)
if (!/^[a-z0-9]+(-[a-z0-9]+)*$/.test(name)) {
    errors.push(
        `NAME ERROR: '${name}' contains invalid characters. ` +
        'Use only lowercase letters, numbers, and single hyphens. ' +
        'No consecutive hyphens, and cannot start/end with a hyphen.'
    );
}

// 3. Validate description length (max 1,024 characters)
if (description.length > 1024) {
    errors.push(
        `DESCRIPTION ERROR: Description is ${description.length} characters. ` +
        'Must be 1,024 characters or fewer.'
    );
}

// 4. Check for first/second-person perspective (basic heuristic)
const FORBIDDEN_WORDS = new Set(['i', 'me', 'my', 'we', 'our', 'you', 'your']);
const descWords = new Set((description.toLowerCase().match(/\b\w+\b/g) || []));
const foundForbidden = [...FORBIDDEN_WORDS].filter(w => descWords.has(w));

if (foundForbidden.length > 0) {
    errors.push(
        `STYLE WARNING: Description contains first/second person terms: {${foundForbidden.join(', ')}}. ` +
        "Use third-person imperative (e.g., 'Creates...', 'Updates...')."
    );
}

// ---------------------------------------------------------------------------
// Output
// ---------------------------------------------------------------------------
if (errors.length > 0) {
    process.stderr.write(errors.join('\n') + '\n');
    process.exit(1);
} else {
    process.stdout.write('SUCCESS: Metadata is valid and optimized for discovery.\n');
    process.exit(0);
}
