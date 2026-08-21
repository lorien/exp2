# GitHub Agent Workflow

Experimental repository: a workflow for planning and implementing things via GitHub issues and pull requests, processed by an [opencode](https://opencode.ai) agent running inside GitHub Actions.

## Key ideas

- **Issue-driven development** — the AI agent is operated entirely through GitHub issues and comments; no local setup needed to run it.
- **Trigger by command** — the first line of an issue body or comment starts with `/agent:research` or `/agent:implement`; everything after is context for the agent.
- **Two agent modes**:
  - `/agent:research` investigates the codebase and the issue, then proposes concrete changes as a comment.
  - `/agent:implement` implements the discussed changes, auto-commits, and opens a pull request — or asks follow-up questions without touching the code when requirements are unclear.
- **Headless execution** — runs inside GitHub Actions with no TTY; status is tracked on the issue (queued → running → done / failed / cancelled) with a link to the run logs.
- **Controlled access** — only collaborators with write access or higher (plus the repo owner) can trigger the agent; commands from anyone else are ignored.
- **Hang-safe permissions** — `opencode.json` removes every `ask` permission (`external_directory`, `doom_loop`, `question`, `read`), so headless runs can never block forever on an unanswerable prompt.
- **Concurrency & timeouts** — a new valid `/agent:` command on the same issue cancels the previous run (invalid mentions never do), and the job is hard-capped at 30 minutes.

## Repository layout

- `.github/workflows/opencode.yml` — the GitHub Actions workflow that runs the agent
- `opencode.json` — opencode configuration, hardened for headless execution
- `spec/ref/github_workflow.md` — detailed documentation of the workflow
- `agent.sh` / `gradient.sh` / `cat.sh` — misc local helper scripts

## Getting started

Full setup instructions, usage examples, and behavior notes are in [spec/ref/github_workflow.md](spec/ref/github_workflow.md). The key prerequisites:

- `OPENCODE_API_KEY` secret set in the repository (OpenCode Go subscription key).
- Trigger users added as collaborators with **Write** level or higher.
- *Allow GitHub Actions to create and approve pull requests* enabled in repository settings.