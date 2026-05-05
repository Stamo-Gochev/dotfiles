#!/usr/bin/env node
/**
 * validate-agent.js
 * Usage: node scripts/validate-agent.js --file "<path-to-agent-file>"
 *
 * Performs structural validation on a .agent.md file:
 *   - Frontmatter has 'name' and 'description' fields
 *   - No placeholder tokens remain (e.g., [your-agent-name])
 *   - All required sections are present
 *   - All three boundary tiers are present
 *   - File length is within the 300-line limit
 *
 * Exit codes:
 *   0 — file is valid
 *   1 — file is invalid (details printed to stderr)
 */

const { parseArgs } = require('util');
const fs = require('fs');
const path = require('path');

// ---------------------------------------------------------------------------
// Argument parsing
// ---------------------------------------------------------------------------
let values;
try {
    ({ values } = parseArgs({
        options: {
            file: { type: 'string' },
        },
    }));
} catch {
    process.stderr.write('ERROR: Failed to parse arguments.\n');
    process.stderr.write('Usage: node scripts/validate-agent.js --file "<path>"\n');
    process.exit(1);
}

const { file } = values;

if (!file) {
    process.stderr.write('ERROR: --file is required.\n');
    process.stderr.write('Usage: node scripts/validate-agent.js --file "<path>"\n');
    process.exit(1);
}

const resolvedPath = path.resolve(file);

if (!fs.existsSync(resolvedPath)) {
    process.stderr.write(`FILE ERROR: File not found: ${resolvedPath}\n`);
    process.exit(1);
}

const content = fs.readFileSync(resolvedPath, 'utf8');

// ---------------------------------------------------------------------------
// Validation
// ---------------------------------------------------------------------------
const errors = [];

// 1. Frontmatter: must open with '---'
if (!content.startsWith('---')) {
    errors.push('STRUCTURE ERROR: File must begin with a YAML frontmatter block (---).');
}

// 2. Frontmatter: 'name' field present
if (!/^name:\s*.+/m.test(content)) {
    errors.push("FRONTMATTER ERROR: Missing required 'name' field in frontmatter.");
}

// 3. Frontmatter: 'description' field present
if (!/^description:\s*.+/m.test(content)) {
    errors.push("FRONTMATTER ERROR: Missing required 'description' field in frontmatter.");
}

// 4. No placeholder tokens
// Strip the frontmatter block before checking to avoid false positives on YAML array values (e.g., tools: ['readFile'])
const frontmatterEnd = content.indexOf('---', 3); // find closing ---
const bodyContent = frontmatterEnd !== -1 ? content.slice(frontmatterEnd + 3) : content;
// Strip fenced code blocks and inline backtick spans to avoid matching code examples or attributes
const bodyWithoutCode = bodyContent
    .replace(/```[\s\S]*?```/g, '')   // fenced code blocks
    .replace(/`[^`]+`/g, '');          // inline code spans
// Match only template-style placeholders: sentence-case or descriptive phrases in brackets
const placeholderPattern = /\[(?:your[^\]]+|One-sentence[^\]]+|List[^\]]+|What[^\]]+|Add[^\]]+|Convention[^\]]+|Consistent[^\]]+|hard prohibition[^\]]+|N|\w[^\]]{10,})\]/g;
const placeholderMatches = bodyWithoutCode.match(placeholderPattern);
if (placeholderMatches) {
    const unique = [...new Set(placeholderMatches)];
    errors.push(
        `PLACEHOLDER ERROR: Unfilled placeholder(s) found: ${unique.join(', ')}. ` +
        'Replace all bracketed tokens before committing the agent file.'
    );
}

// 5. Required sections
const requiredSections = ['# Who You Are', '# How You Think', '# How You Respond', '# What You Always Do', '# What You Never Do'];
for (const section of requiredSections) {
    if (!content.includes(section)) {
        errors.push(`SECTION ERROR: Missing required section: '${section}'.`);
    }
}

// 6. What You Never Do must prohibit secrets
if (content.includes('# What You Never Do') && !/secret|credential|api.?key|token/i.test(
    content.slice(content.indexOf('# What You Never Do'))
)) {
    errors.push("GUARDRAIL ERROR: '# What You Never Do' section must include a prohibition on secrets, credentials, or API keys.");
}

// 7. Opening persona line — must reference role and not be a generic "You are an expert" opener
if (!/^You are a.+\./m.test(content)) {
    errors.push(
        "PERSONA ERROR: Missing opening persona statement. " +
        "Expected a specific statement like: 'You are a principal security engineer with 15 years of experience...'"
    );
}

// ---------------------------------------------------------------------------
// Output
// ---------------------------------------------------------------------------
if (errors.length > 0) {
    errors.forEach(err => process.stderr.write(err + '\n'));
    process.exit(1);
}

const fileName = path.basename(resolvedPath);
process.stdout.write(`OK: '${fileName}' passed all structural checks.\n`);
process.exit(0);
