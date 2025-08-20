# LR Tools (lr-tools)  
![License](https://img.shields.io/badge/license-Apache--2.0-blue) ![Python](https://img.shields.io/badge/python-3.10%2B-brightgreen)

Human-friendly utilities for fast, reliable human+agent workflows:
- A terminal FIFO listener/executor to run commands safely from agents without hijacking your shell.
- Timestamped Markdown reports with YAML frontmatter to keep a durable narrative across sessions.
- Handy generators and recipes to keep momentum (Make targets, tmp script generator).

Apache-2.0. See `LICENSE`.

## What’s inside
- [shadeos_start_listener.py](./shadeos_start_listener.py) — zero‑config launcher for the FIFO terminal listener
- [terminal_injection/shadeos_term_listener.py](./terminal_injection/shadeos_term_listener.py) — executes commands from a FIFO, mirrors to TTY
- [terminal_injection/shadeos_term_exec.py](./terminal_injection/shadeos_term_exec.py) — injector (FIFO/tmux/PTY), with recipes and logging
- [bin/new_report](./bin/new_report) — generate timestamped Markdown reports with frontmatter
- [bin/new_tmp_script](./bin/new_tmp_script) — generate timestamped bash or python scripts under `scripts/tmp/`
- [tutorials/](./tutorials) — concise guides (Cursor dual‑channel, vibecoding, context regeneration, Make recipes)

## Quickstart

### Install
Local editable (dev):
```bash
pip install -e .
```

Via pipx (user‑level):
```bash
pipx install .
```

### Run the listener
Start the listener in the terminal you want to observe:
```bash
python shadeos_start_listener.py
```
You should see READY and the FIFO path (default `/tmp/shadeos_cmd.fifo`). Leave this terminal open.

### Send a command (from another process)
```bash
python terminal_injection/shadeos_term_exec.py --cmd "echo HELLO" --tee-log /tmp/shadeos.log --wake
```
- `--wake` sends Ctrl‑C first to recover a stuck prompt
- `--recipe unit-fast` runs a predefined command bundle

### Create a timestamped report
```bash
LR_Tools/bin/new_report Overview "My First Report"
# → Reports/Overview/My_First_Report_<day>_<month>_<year>_<Hh>_<Mm>_<Ss>.md
```

### Create a timestamped tmp script (bash/python)
```bash
# Bash
LR_Tools/bin/new_tmp_script bash "Quick helper" --exec
# Python
LR_Tools/bin/new_tmp_script py "Probe something" --exec
# Files land in scripts/tmp/<Title>_<day>_<month>_<year>_<Hh>_<Mm>_<Ss>.{sh,py}
```

### Environment variables
- `SHADEOS_FIFO` — FIFO path for the listener (default `/tmp/shadeos_cmd.fifo`)
- `SHADEOS_TOOLS_DIR` — override autodetection of tools dir

## Tutorials
- [Cursor dual‑channel workflow](./tutorials/00_cursor_workflow.md)
- [Vibecoding workflow](./tutorials/01_vibecoding_workflow.md)
- [Regenerate context with reports](./tutorials/02_context_regeneration_with_reports.md)
- [Makefile targets and recipes](./tutorials/03_makefile_and_recipes.md)
- [Temporary script generator (bash/python)](./tutorials/04_tmp_script_generator.md)
 - [Quickstart in 60 seconds](./tutorials/05_quickstart_in_60s.md)

## Ecosystem
Pairs nicely with LR Package Manager (lr‑pm) for manifests, lockfiles, and submodule helpers.
- Repo (release): https://github.com/L-Defraiteur/lr-package-manager
- Typical commands: `lr pm init`, `lr pm info`, `lr pm lock`, `lr pm sync --apply`, `lr pm run <alias>`

## Example reports
Public examples of timestamped reports showcasing the workflow:
- Scrap IA Reports: https://github.com/L-Defraiteur/scrap-ia-reports

## Who is this for?
- Developers and teams orchestrating commands via agents while keeping terminal control
- Anyone wanting durable, searchable context via timestamped Markdown
- Python 3.10+ recommended

## Quick reference
- Listener: `python shadeos_start_listener.py`
- Injector: `python terminal_injection/shadeos_term_exec.py --cmd "…" [--wake --tee-log …]`
- New report: `LR_Tools/bin/new_report <Category> "Title" [--seconds]`
- New tmp script: `LR_Tools/bin/new_tmp_script <bash|py> "Title" --exec`
- Manifest aliases: `./bin/lr pm run tmp_bash` or `TITLE="X" ./bin/lr pm run tmp_py`

## FIFO flow (ASCII)
```
[Agent/Script] --(inject cmd)--> [FIFO] --> [Listener] --> [TTY + Logs]
                                 ^                          |
                                 |                          v
                              (recipes)               Reports / scripts/tmp
```

## Troubleshooting
- Prompt stuck: add `--wake` to injector (sends Ctrl‑C)
- No FIFO: ensure the listener is running (shows FIFO path)
- Permission denied on tmp script: use `--exec` or `chmod +x`
- Timestamps collide: generator uses seconds; titles are sanitized

## Manifest snippet
```yaml
commands:
  tmp_bash: "bash -lc 'LR_Tools/bin/new_tmp_script bash \"${TITLE:-QuickTmp}\" --exec'"
  tmp_py:   "bash -lc 'LR_Tools/bin/new_tmp_script py \"${TITLE:-QuickTmp}\" --exec'"
```
