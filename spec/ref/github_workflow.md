# GitHub Workflow

This repository has an AI coding agent (powered by [opencode](https://opencode.ai)) integrated through GitHub Actions. You operate the agent by creating issues or writing comments on issues.

## How it works

The workflow runs on two events:

- a new issue is opened (`issues: opened`)
- a new comment is posted on an issue (`issue_comment: created`)

But it only does anything if the **first line** of the issue body or comment starts with the `/agent:` prefix. Any text on the lines after the command is passed to the agent as context, so feel free to describe your request in detail below the command.

## Commands

Put one of the following as the very first line of the issue body or a comment:

| Command | What the agent does |
| --- | --- |
| `/agent:research` | Investigates the codebase and the issue, then proposes concrete changes. The proposal is posted as a comment on the issue. |
| `/agent:implement` | Implements the changes discussed in the issue. The system automatically commits the changes and opens a pull request. If the requirements are unclear, the agent posts follow-up questions as a comment and makes no code changes. |
| anything else starting with `/agent:` | The bot replies with an "invalid mention" comment listing the supported commands. |

## Examples

Create a new issue with the following body:

```
/agent:implement

Add a delete confirmation dialog to the notes page.
```

Or comment on an existing issue:

```
/agent:research

Explain how authentication is handled in this repo.
```

## Behavior notes

- Only the first line of the message is parsed as the command. Everything after it is content for the agent.
- The bot's own replies (research proposals, follow-up questions, "invalid mention", "Created PR #N") never start with `/agent:`, so they do not re-trigger the workflow.
- The user who triggers the workflow needs write access to the repository.
- After `/agent:implement`, the agent's final message becomes the pull request description.

## Setup / prerequisites

- The `OPENCODE_API_KEY` secret must be set in the repository (Settings → Secrets and variables → Actions). It is an OpenCode Go subscription key.
- The model used is `opencode-go/deepseek-v4-flash`.
- Commits and pull requests created by the workflow are attributed to `opencode-agent[bot]`.
- **Required:** enable *"Allow GitHub Actions to create and approve pull requests"* in the repository settings (**Settings → Actions → General → Workflow permissions**). Without it, `/agent:implement` cannot create pull requests and the run fails with "GitHub Actions is not permitted to create or approve pull requests." If the repository belongs to an organization, an org admin may need to enable the same setting at the organization level.

## Source

The workflow definition lives in `.github/workflows/opencode.yml`.