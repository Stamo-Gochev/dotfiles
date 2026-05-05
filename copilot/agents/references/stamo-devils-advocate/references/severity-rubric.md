# Severity Rubric

Use this rubric to assign a severity level to each finding produced by the `stamo-devils-advocate` skill.

When writing findings to the raw JSON file, use the lowercase token values for the `severity` field: `critical`, `warning`, or `advisory`. The emoji labels (🔴 / 🟡 / 🔵) are display labels only and must not be used as `severity` field values in JSON.

---

## 🔴 Critical

Assign `🔴 Critical` when the finding meets **any** of the following criteria:

- Violates a `🔴 Block` rule in a repo instruction file (`.github/instructions/*.instructions.md`).
- Introduces a logic error or regression that will produce incorrect behavior under a non-exotic condition.
- Causes or risks a memory leak, event listener leak, or unhandled async exception.
- Removes or bypasses an existing safety check without a documented reason.
- A performance issue that will affect rendering on every interaction (e.g., LINQ in a property getter, missing `ShouldRender` on a high-frequency component).

**Action**: Suggest a concrete fix. Offer to apply it in Step 6.

---

## 🟡 Warning

Assign `🟡 Warning` when the finding meets **any** of the following criteria:

- Violates a `🟡 Warn` rule in a repo instruction file.
- An edge case that is unlikely but plausible in real-world usage (e.g., null ref on an optional parameter).
- A design decision with a clearly better alternative, but the current approach is not wrong.
- Missing test coverage for a behavioral path introduced by the change.
- A debatable naming, structure, or API shape choice that may confuse future maintainers.

**Action**: Explain the concern and suggest an alternative. Do not auto-apply.

---

## 🔵 Advisory

Assign `🔵 Advisory` when the finding meets **all** of the following criteria:

- Does not violate any repo instruction rule.
- The current approach works correctly in all known scenarios.
- An alternative exists that could improve clarity, future-proofing, or discoverability.
- The concern is worth surfacing but reasonable engineers could disagree.

**Action**: Mention it briefly. Do not suggest a fix unless asked.

---

## Exclusion Rule

Do **not** create a finding when:

- The approach is standard, clearly intentional, and has no evident downside.
- The only objection is a stylistic preference not grounded in a repo rule.
- The concern duplicates a finding already listed (merge duplicates).
