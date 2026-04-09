# Skillify for Codex

Turn a completed Codex workflow into a reusable Codex skill.

## What It Is

`skillify` is a Codex skill that looks at a completed or nearly completed Codex session, extracts the repeatable workflow, and turns it into a reusable `SKILL.md`.

Use it when a session produced a process worth repeating, such as debugging, PR review, release preparation, or repository analysis.

## Installation

Copy this repository into a Codex skills directory.

### Project-local install

```bash
mkdir -p .codex/skills
cp -R /path/to/skillify-for-codex .codex/skills/skillify
```

### User-level install

```bash
mkdir -p ~/.codex/skills
cp -R /path/to/skillify-for-codex ~/.codex/skills/skillify
```

After installation, the main skill file should exist at:
- `.codex/skills/skillify/SKILL.md`
- or `~/.codex/skills/skillify/SKILL.md`

## Usage

Invoke the skill from Codex after finishing a workflow that you want to save as a reusable skill.

Example prompts:

```text
Use the skillify skill on this completed workflow.
```

```text
skillify this debugging and verification flow
```

```text
skillify this PR review workflow and save it under .codex/skills/
```
