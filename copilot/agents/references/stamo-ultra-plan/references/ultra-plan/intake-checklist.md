# Ultra Plan Intake Checklist

Use this checklist before launching planners.

## 1) Outcome Definition

- What exactly should be achieved?
- What is out of scope?
- What does success look like?

## 2) Constraints

- Time, dependency, platform, compliance, and budget constraints
- Existing architecture constraints
- Required compatibility boundaries

## 3) Quality Expectations

- Reliability targets
- Performance targets
- Security/privacy requirements
- Operational requirements (monitoring, rollback, ownership)

## 4) Delivery Shape

- Required artifacts and format
- Decision authority and approval checkpoints
- Known deadlines or fixed milestones

## 5) Ambiguity Gate

If any of these are unclear, ask targeted questions before planner dispatch:

- Scope boundary
- Non-goals
- Acceptance criteria
- Constraints that change architecture

## 6) Interactive Question Classification

Classify each intake question as:

- **Blocking**: required to produce a valid plan. Must be answered before planner dispatch.
- **Non-blocking**: useful but not mandatory for first-pass planning. Can remain open with explicit assumption.

Default blocking topics:

- Required capabilities and launch scope
- Out-of-scope boundaries
- Non-negotiable constraints (platform, compliance, performance, security)
- Acceptance criteria that define success/failure

Default non-blocking topics:

- Nice-to-have enhancements
- Post-v1 preferences
- Optional UX details that do not invalidate core architecture

## Output from Intake

Produce a short task packet:

- Objective
- In-scope / out-of-scope
- Constraints
- Acceptance criteria
- Known risks
- Blocking questions + answers
- Non-blocking open questions (if any)
- Explicit assumptions used for unanswered non-blocking items
