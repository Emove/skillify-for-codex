# Example: Codex Skill Output

## Input Session

User performed a code review workflow:
1. Read the PR diff using `gh pr diff`
2. Analyzed for security issues
3. Checked for code style violations
4. Verified test coverage
5. Posted review comments using `gh pr review`

## Generated Output

**File**: `.codex/skills/code-reviewer/SKILL.md`

```markdown
---
name: code-reviewer
description: Use when reviewing pull requests for security, style, and test coverage before human approval.
---

# Code Reviewer

Review pull requests systematically and surface actionable findings before human approval.

## Goal

Inspect the PR diff for security, style, and test coverage risks, then summarize findings clearly.

## Workflow

### 1. Fetch PR Changes

Get the diff for the PR being reviewed.

```bash
gh pr diff <pr-number>
```

**Success criteria**:
- PR diff is retrieved
- files changed are identified

### 2. Security Analysis

Check for common security issues:
- hardcoded secrets or credentials
- SQL injection risks
- XSS vulnerabilities
- unsafe eval or exec usage
- insecure dependency changes

**Success criteria**:
- security review is complete
- concrete findings include file references

### 3. Style Review

Verify code style compliance:
- linting and formatting rules
- naming conventions
- import organization
- consistency with nearby code

```bash
npm run lint || npx eslint . || true
```

**Success criteria**:
- style violations are identified
- auto-fixable issues are separated from manual issues

### 4. Test Coverage Check

Verify adequate test coverage for the changed behavior.

```bash
npm test -- --coverage || npm run test:coverage || true
```

**Success criteria**:
- tests were evaluated
- missing coverage is called out where relevant

### 5. Post Review

Summarize findings in clear review language and post them if requested.

```bash
gh pr review <pr-number> --comment -b "<review-body>"
```

**Success criteria**:
- review output is ready or posted
- each blocking issue is concrete and actionable

## Checks

- no hardcoded secrets
- no injection or XSS risks
- changed behavior has adequate tests
- style and formatting checks were considered

## Escalation

- ask the user before posting review comments externally
- escalate when architecture concerns exceed the changed scope
- escalate when the diff requires domain knowledge not present in the repo
```

## Usage in Codex

Once saved, refer to it in your prompt, for example:

```text
Use the code-reviewer skill on PR #123.
```
