# Cursor + LR Tools — Dual‑Channel Workflow

This tutorial shows how to use Cursor (or any code assistant) in a dual‑channel workflow:
- A terminal listener (FIFO) that executes reliable shell commands and mirrors output into your visible terminal.
- Timestamped reports that capture decisions and context, so both humans and agents can quickly regenerate working state.

## Why dual‑channel?
- Cursor edits code and crafts commands; the listener executes them safely without hijacking your terminal.
- Reports provide durable memory: agents (and you) can restart sessions by skimming the latest notes.

## Prerequisites
- Install `LR_Tools` (local editable or pipx once published):
```bash
pip install -e .
# or
pipx install .
```

## Start the listener
In the terminal you want to observe:
```bash
python shadeos_start_listener.py
```
You should see READY and the FIFO path (default `/tmp/shadeos_cmd.fifo`). Leave this terminal open.

## Send commands from Cursor (or any agent/tool)
From another process (Cursor, script, CI), inject commands via the injector:
```bash
python terminal_injection/shadeos_term_exec.py --cmd "pytest -q" --tee-log /tmp/session.log --wake
```
Tips:
- `--wake` sends Ctrl‑C first to recover a stuck prompt.
- `--timeout-sec 60` bounds long commands.
- Use `--recipe unit-fast` or `--recipe all` for common flows.

## Capture context with reports
Create a timestamped report when you reach a checkpoint (see [bin/new_report](../bin/new_report)):
```bash
AUTHOR="Your Name" TAGS="plan,scope,tests" LR_Tools/bin/new_report Overview "Progress Checkpoint"
```
Edit the new file under `Reports/Overview/*.md` to summarize:
- What changed, why it matters
- Current blockers and decisions
- Next actions (short checklist)

## Regenerate context later
When returning to the project, skim the latest reports (sorted by timestamp). Agents can:
- List `Reports/**.md`, pick the most recent files, parse the frontmatter, and synthesize a working brief.
- Pull relevant commands from the notes to restart flows (`pytest`, smoke checks, sync steps).

## Related
- [Vibecoding workflow](./01_vibecoding_workflow.md)
- [Regenerate context with reports](./02_context_regeneration_with_reports.md)
- [Makefile targets and recipes](./03_makefile_and_recipes.md)
- [Temporary script generator (bash/python)](./04_tmp_script_generator.md) — quickly scaffold timestamped helpers via [bin/new_tmp_script](../bin/new_tmp_script)
