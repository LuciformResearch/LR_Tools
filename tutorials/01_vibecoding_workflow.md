# Vibecoding with LR Tools — A Practical Workflow

This guide shows how to set up a fast, low‑friction loop to iterate with agents and humans using the terminal FIFO listener and the report generator.

## Goals
- Keep your terminal free while agents execute commands reliably
- Capture context and decisions in timestamped reports for later regeneration
- Use small, repeatable commands ("recipes") to preserve vibe and momentum

## Setup
1) Start the FIFO listener in the terminal you want to control:
```bash
python shadeos_start_listener.py
```
2) From another shell or an agent process, send commands via the injector:
```bash
python terminal_injection/shadeos_term_exec.py --cmd "pytest -q"
```
3) Optional: store logs
```bash
python terminal_injection/shadeos_term_exec.py --cmd "pytest -q" --tee-log /tmp/session.log
```

## Daily loop
- Keep one terminal dedicated to the listener.
- Send short, bounded commands (add `--timeout-sec 60` if useful).
- Use reports to checkpoint decisions, plans, and the next steps.

## Quick checkpoints
Create a report at decision points:
```bash
AUTHOR="Your Name" TAGS="plan,scope,tests" \
  LR_Tools/bin/new_report Overview "Progress Checkpoint"
```
Edit the file and jot down:
- What changed
- Why it changed
- What to do next

## Tips
- Use `--wake` (sends Ctrl‑C) if the prompt is stuck.
- Prefer the FIFO backend over PTY to avoid CR/LF quirks.
- Add `--enter-times 2` if the shell needs extra newlines.
