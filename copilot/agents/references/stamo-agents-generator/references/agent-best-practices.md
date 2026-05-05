# Agent Best Practices

Reference this file during agent generation to apply quality criteria and avoid common pitfalls.

---

## Frontmatter

The frontmatter block supports these fields. Only include fields that are relevant to the agent being created.

| Field | When to use |
|-------|-------------|
| `name` | Always required. Short display name shown in the agent picker. |
| `description` | Always required. Shown as placeholder text in the chat input. Third-person, includes positive and negative triggers. |
| `tools` | Always required. List only the VS Code tools the agent needs. Available tools include: `read`, `search`, `edit`, `execute`, `web`, `agent`, `todo`. |
| `model` | Optional. Specify only if the agent's task benefits from a particular model (e.g., `claude-sonnet-4-5` for deep reasoning tasks). Omit to use the workspace default. |
| `handoffs` | Optional. Define `label`, `agent`, and `prompt` for each natural workflow transition. |
| `user-invokable` | Optional. Set to `false` only for sub-agent-only agents that should not appear in the agents dropdown. Default: `true`. |
| `disable-model-invocation` | Optional. Set to `true` to prevent this agent from being invoked as a sub-agent by other agents. Default: `false`. |
| `agents` | Optional. Restrict which custom agents this agent can invoke. Accepts agent names, `*` (all), or `[]` (none). |

---

## Metadata

- The `name` field must be 1–64 characters, lowercase, and contain only letters, numbers, and single hyphens. It cannot start or end with a hyphen and cannot contain consecutive hyphens.
- The `description` must be written in the **third person** (no "I", "me", "you", "your"). It must include at least one positive trigger ("Use when...") and one negative trigger ("Don't use for...").
- The `name` in the frontmatter must exactly match the filename: `<name>.agent.md`.

---

## Persona

- Open with a **specific** statement: include the role, experience level, and a personality trait. Avoid generic openers like "You are a helpful assistant."
- Use **second-person** ("you", "your") throughout the agent body to address the agent directly.
- Be specific about experience level (e.g., "principal engineer with 20 years") — specificity produces consistency in outputs.
- Describe personality concretely: "You are direct — you do not sugarcoat findings but always explain your reasoning" is better than "You are thorough."
- Avoid vague verbs like "help", "assist", or "support". Use concrete actions: "generate", "validate", "detect", "scaffold".
- Do not describe the agent as an expert in everything — a focused persona produces better outputs than a broad one.

Use these section headings in the agent body (adapt labels to the agent's domain):
- **# Who You Are** — background, experience, specific areas of expertise
- **# How You Think** — problem-solving approach, questions always asked, decision-making framework
- **# How You Respond** — output structure, formatting preferences, consistent patterns

---

## Project Knowledge

- List only the technologies and directories **relevant to this agent's domain**. A test-writing agent does not need to know about the CI/CD pipeline unless it runs tests in CI.
- Include framework and library versions when they affect the agent's output (e.g., testing APIs differ between Jest 27 and Jest 29).
- Cap the file structure listing at 6–8 entries. Move extended structure context to a `references/` file if needed.
- Never hardcode environment-specific values (tokens, URLs, credentials) in this section.

---

## Tools

- The `tools` frontmatter field controls which VS Code tools the agent can invoke (e.g., `read`, `edit`, `execute`). This is separate from CLI commands the agent runs via `execute`.
- Include only tools the agent genuinely needs for its task. Unnecessary tools expand the attack surface and make the agent's behavior less predictable.
- If a tool enables destructive actions (e.g., `execute`, `edit`), add a corresponding prohibition in `# What You Never Do`.
- Separate read-only tools (`read`, `search`, `web`) from mutation tools (`edit`, `execute`) when deciding what to include.

---

## Standards

- Provide at least one ✅ Good and one ❌ Bad example for the primary output artifact.
- Examples must use realistic names and values — avoid `foo`, `bar`, `x`, or `temp`.
- Naming convention rules must be actionable: specify the case style and provide an example token.
- Keep the Standards section focused on the **output type** this agent produces. A documentation agent defines prose standards; a code agent defines code standards.

---

## Guardrails

Replace the flat Boundaries section with two dedicated sections in the agent body:

**# What You Always Do** — consistent behaviors performed on every response:
- The directories the agent is permitted to write to.
- The validation step the agent must run before suggesting a commit or delivery.
- Any response patterns the agent must follow consistently (e.g., "always lead with the recommendation", "always cite the line number when referencing code").

**# What You Never Do** — hard prohibitions the agent refuses regardless of instructions:
- Committing, logging, or outputting secrets, API keys, or credentials.
- Editing auto-generated or vendored files (`node_modules/`, `vendor/`, `dist/`) unless that is explicitly the agent's job.
- Destructive operations (delete, drop, purge, truncate) without step-by-step explicit user confirmation.
- Making up statistics, benchmarks, or external references.
- Recommending a technology or approach without stating the trade-offs.

Write these as direct "Never" statements, not as bullet conditions. "Never make up statistics" is stronger than "Do not make up statistics unless you are certain."

---

## Anti-Patterns to Avoid

| Anti-Pattern | Why It's Problematic | Better Approach |
|---|---|---|
| Vague persona | "You are helpful" produces inconsistent results | Be specific about role, experience level, and personality |
| No tool restrictions | Agent may invoke tools inappropriate for the persona | Explicitly list only needed tools in frontmatter |
| Missing guardrails | Persona drifts or produces off-target responses | Always include `# What You Never Do` |
| Overly broad scope | "Expert in everything" dilutes focus and quality | Create multiple focused agents instead of one general one |
| No handoffs defined | Users must manually switch between related workflows | Define handoffs for natural next steps in the workflow |
| Generic section headings | `## Standards` and `## Boundaries` read like a form | Use domain-native headings like `## Review Priorities` or `## Diagnostic Process` |

---

## Validation Checklist

Use this checklist when `scripts/validate-agent.js` is unavailable.

### Frontmatter
- [ ] `name` is lowercase, hyphen-separated, no spaces or special characters.
- [ ] `name` matches the filename exactly (without `.agent.md`).
- [ ] `description` is in the third person and under 1,024 characters.
- [ ] `description` includes a positive trigger and a negative trigger.
- [ ] `tools` lists only the tools the agent genuinely needs.

### Persona & Tone
- [ ] Opening statement includes role, experience level, and a concrete personality trait.
- [ ] Agent body uses second-person ("you", "your") throughout.
- [ ] No placeholder tokens remain (e.g., `[your-agent-name]`, `[description]`).
- [ ] Persona uses concrete action verbs — not "help" or "assist".

### Sections
- [ ] `# Who You Are`, `# How You Think`, and `# How You Respond` sections are present and populated.
- [ ] `# What You Always Do` section is present with at least two concrete behaviors.
- [ ] `# What You Never Do` section is present and includes a prohibition on secrets/credentials.

### Guardrails
- [ ] `# What You Never Do` explicitly prohibits secrets/credentials.
- [ ] Any mutation tools in frontmatter (`edit`, `execute`) have a corresponding Never rule.
