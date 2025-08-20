# LR Tools (lr-tools)

Public subset of LR_Tools: context‑regeneration workflow, terminal FIFO listener/executor, and helper scripts.

Built for context flow: alongside the FIFO listener, you generate timestamped Markdown reports (with YAML frontmatter) to capture decisions and next steps. On a fresh session, humans and agents can quickly regenerate working context by skimming the latest reports.

- `shadeos_start_listener.py` — zero-config launcher for terminal FIFO listener
- `terminal_injection/shadeos_term_listener.py` — robust FIFO-based command executor mirroring to TTY
- `terminal_injection/shadeos_term_exec.py` — send commands to an existing terminal via FIFO, tmux, or PTY

Apache-2.0. See `LICENSE`.

## Table of contents
- [Quickstart](#quickstart)
- [Usage](#usage)
- [Tutorials](#tutorials)
- [Ecosystem](#ecosystem)
- [Example reports](#example-reports)

## Quickstart

### Install

Local editable (dev):
```bash
pip install -e .
```

Via pipx (user-level):
```bash
pipx install .
```

### Usage

Start the FIFO listener in the terminal you want to control:
```bash
python shadeos_start_listener.py
```

Send a command from another process:
```bash
python terminal_injection/shadeos_term_exec.py --cmd "echo HELLO"
```

Advanced (tmux, PID, wake, logs):
```bash
python terminal_injection/shadeos_term_exec.py --recipe unit-fast --tee-log /tmp/shadeos.log --wake
```

Generate a new report with frontmatter:
```bash
LR_Tools/bin/new_report Overview "My First Report"  # creates Reports/Overview/My_First_Report_<timestamp>.md
```

Environment variables:
- `SHADEOS_FIFO`: FIFO path (default `/tmp/shadeos_cmd.fifo`)
- `SHADEOS_TOOLS_DIR`: override tools dir auto-detection

## Tutorials
- `tutorials/00_cursor_workflow.md`
- `tutorials/01_vibecoding_workflow.md`
- `tutorials/02_context_regeneration_with_reports.md`
- `tutorials/03_makefile_and_recipes.md`

## Ecosystem
LR Tools works standalone, but pairs nicely with the package manager:

- LR Package Manager (lr-pm): manifest/lock + PYTHONPATH wiring and submodule helpers.
  - Key commands: `lr pm init`, `lr pm info`, `lr pm lock`, `lr pm sync --apply`, `lr pm run <alias>`

## Example reports
See a public collection of timestamped reports showcasing the workflow:

- Scrap IA Reports (this repo’s `Reports/` folder)
