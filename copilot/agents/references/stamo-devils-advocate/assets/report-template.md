# Devil's Advocate Report

**Date**: {{DATE}}
**Input type**: {{INPUT_TYPE}} <!-- git diff | plan | decision | PR -->
**Files / areas reviewed**: {{FILES_OR_AREAS}}

---

## Summary

{{SUMMARY}}

---

## Findings

<!-- Repeat the block below for each finding. Remove tiers with zero findings. -->
<!-- Use normalized findings from .github/agents/workspace/devils-advocate-findings.json and keep stable ordering by severity. -->

### 🔴 Critical

| # | Title | Location | Explanation | Suggested Fix |
|---|-------|----------|-------------|---------------|
| 1 | {{TITLE}} | {{FILE}}:{{LINE}} | {{EXPLANATION}} | {{FIX}} |

---

### 🟡 Warning

| # | Title | Location | Explanation | Suggested Alternative |
|---|-------|----------|-------------|----------------------|
| 1 | {{TITLE}} | {{FILE}}:{{LINE}} | {{EXPLANATION}} | {{ALTERNATIVE}} |

---

### 🔵 Advisory

| # | Title | Explanation |
|---|-------|-------------|
| 1 | {{TITLE}} | {{EXPLANATION}} |

---

## Verdict

{{VERDICT}}

---

## End-Game Synthesis (filled after user ends analysis)

**Overall resilience**: {{RESILIENCE}}
**Strongest defenses**: {{DEFENSES}}
**Remaining vulnerabilities**: {{VULNERABILITIES}}
**Concessions & mitigations**: {{CONCESSIONS}}
