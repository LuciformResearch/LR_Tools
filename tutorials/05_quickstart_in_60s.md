# Quickstart in 60 seconds

Follow this short, end‑to‑end path to feel the workflow.

## 1) Start the listener (in the terminal you’ll observe)
```bash
python shadeos_start_listener.py
```
- You should see READY and the FIFO path (default `/tmp/shadeos_cmd.fifo`). Keep this terminal open.

## 2) From another terminal, send a command via the injector
```bash
python terminal_injection/shadeos_term_exec.py --cmd "echo HELLO" --tee-log /tmp/shadeos.log --wake
```
- `--wake` sends Ctrl‑C first to recover a stuck prompt.

## 3) Create a timestamped report (frontmatter + Markdown)
```bash
LR_Tools/bin/new_report Overview "First Checkpoint" --seconds
```
- Open the created file under `Reports/Overview/` and jot down what changed and next steps.

## 4) Create a timestamped temporary script (bash or python)
```bash
LR_Tools/bin/new_tmp_script bash "Quick helper" --exec
LR_Tools/bin/new_tmp_script py "Probe provider" --exec
```
- Files land in `scripts/tmp/<Title>_<day>_<month>_<year>_<Hh>_<Mm>_<Ss>.{sh,py}`.

## 5) (Optional) Use manifest aliases to generate tmp scripts
```bash
./bin/lr pm run tmp_bash
TITLE="My Probe" ./bin/lr pm run tmp_py
```

You’ve just used the listener, the injector, and both generators.
