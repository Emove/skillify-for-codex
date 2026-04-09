---
name: skillify
description: Use when the user wants to turn a completed Codex workflow into a reusable Codex skill, especially after a repeatable debugging, review, refactor, or delivery process.
---

# Skillify

Turn the current Codex session into a reusable Codex skill.

## Goal

Produce an installable skill directory with:
- a concise `SKILL.md`
- a stable skill name and description
- clear steps, checks, and escalation rules
- no Claude-specific content

Default output path:
- project-local: `.codex/skills/<skill-name>/SKILL.md`
- personal: `~/.codex/skills/<skill-name>/SKILL.md`

If the user does not specify, prefer the project-local path.

## When To Use

Use this skill at the end of a workflow that is likely to repeat, for example:
- bugfix and verification flows
- code review and comment resolution flows
- release, deploy, or PR preparation flows
- repo analysis or migration flows
- any session where the user says "make this reusable", "save this as a skill", or "skillify this"

Do not use it for one-off work with no stable sequence.

## Workflow

### 1. Gather Codex Session Context

Inspect the recent Codex session before drafting anything.

Preferred sources:
- `./get-session-context.sh`
- `~/.codex/history.jsonl`
- `~/.codex/session_index.jsonl`
- `~/.codex/sessions/...`
- the current repository diff, files touched, and commands run in this session

Extract:
- the workflow goal
- ordered steps
- required inputs
- success criteria
- files, tools, and commands involved
- points where the user corrected scope or constraints

### 2. Draft the Skill Shape

Propose:
- skill name in kebab-case
- one-sentence description that starts with `Use when...`
- save location
- the smallest useful input surface

If details are missing, make reasonable defaults instead of blocking. Ask only short plain-text follow-ups when a missing detail would materially change the output.

### 3. Write a Codex Skill

Write `SKILL.md` in Codex skill format:

```markdown
---
name: {{skill-name}}
description: Use when {{triggering conditions only}}
---

# {{Title}}

## Goal
What outcome this skill should produce.

## Workflow

### Step 1: Name
What to do.

**Success criteria**:
- Concrete completion signal

### Step 2: Name
...

## Checks
- Verification item

## Escalation
- When to ask the user to decide
```

Keep the skill focused on:
- stable step ordering
- concrete checks
- small input surface
- Codex-native wording and tools

### 4. Review Before Saving

Check the draft for:
- Claude-specific terms, paths, or tools
- workflow text hidden inside `description`
- unnecessary frontmatter beyond `name` and `description`
- missing verification or escalation rules
- one-off project details that should not become a reusable skill

### 5. Save and Report

Save the final file to the chosen Codex skill directory.

Report:
- saved path
- skill name
- how to invoke it in Codex
- any assumptions baked into the skill

## Rules

- Do not produce Claude Code files, examples, or paths.
- Do not generate `agents/*.md` or agent TOML as the primary output.
- Default to Codex skill directories under `.codex/skills/` or `~/.codex/skills/`.
- Prefer concise skill docs. Keep only reusable process knowledge.
- Use ordinary conversation for clarification; do not depend on unavailable custom question tools.
