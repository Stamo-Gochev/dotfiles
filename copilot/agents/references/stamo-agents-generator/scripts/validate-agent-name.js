#!/usr/bin/env node
/**
 * validate-agent-name.js
 * Usage: node scripts/validate-agent-name.js --name "<name>"
 *
 * Validates the agent name against the naming rules:
 *   - 1–64 characters
 *   - Lowercase letters, numbers, and single hyphens only
 *   - Cannot start or end with a hyphen
 *   - No consecutive hyphens
 *
 * Exit codes:
 *   0 — name is valid
 *   1 — name is invalid (details printed to stderr)
 */

const { parseArgs } = require('util');

// ---------------------------------------------------------------------------
// Argument parsing
// ---------------------------------------------------------------------------
let values;
try {
    ({ values } = parseArgs({
        options: {
            name: { type: 'string' },
        },
    }));
} catch {
    process.stderr.write('ERROR: Failed to parse arguments.\n');
    process.stderr.write('Usage: node scripts/validate-agent-name.js --name "<name>"\n');
    process.exit(1);
}

const { name } = values;

if (!name) {
    process.stderr.write('ERROR: --name is required.\n');
    process.stderr.write('Usage: node scripts/validate-agent-name.js --name "<name>"\n');
    process.exit(1);
}

// ---------------------------------------------------------------------------
// Validation
// ---------------------------------------------------------------------------
const errors = [];

// 1. Length check (1–64 characters)
if (name.length < 1 || name.length > 64) {
    errors.push(
        `NAME ERROR: '${name}' is ${name.length} character(s). Must be between 1 and 64.`
    );
}

// 2. Character and format check
if (!/^[a-z0-9]+(-[a-z0-9]+)*$/.test(name)) {
    errors.push(
        `NAME ERROR: '${name}' contains invalid characters or formatting. ` +
        'Use only lowercase letters, numbers, and single hyphens. ' +
        'Cannot start or end with a hyphen. No consecutive hyphens allowed.'
    );
}

// ---------------------------------------------------------------------------
// Output
// ---------------------------------------------------------------------------
if (errors.length > 0) {
    errors.forEach(err => process.stderr.write(err + '\n'));
    process.exit(1);
}

process.stdout.write(`OK: Agent name '${name}' is valid. File will be written to .github/agents/${name}.agent.md\n`);
process.exit(0);
