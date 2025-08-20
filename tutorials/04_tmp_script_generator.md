# Temporary Script Generator — Timestamped Bash/Python under `scripts/tmp/`

Generate timestamped temporary scripts for quick experiments and traceability. Files land under `scripts/tmp/` and include a header with title/author/created.

## Why
- Keep throwaway helpers organized per‑session (by timestamp)
- Share reproducible snippets without polluting the main codebase
- Easy to promote later into a permanent script if useful

## Usage
```bash
# Bash script
LR_Tools/bin/new_tmp_script bash "My quick helper" --exec
# Python script
LR_Tools/bin/new_tmp_script py "Probe provider health" --exec
```
Output examples:
- `scripts/tmp/My_quick_helper_20250821-000536.sh`
- `scripts/tmp/Probe_provider_health_20250821-000536.py`

## Notes
- `--exec` makes the new file executable right away
- Filenames are sanitized (spaces → `_`) and timestamped with seconds
- Consider committing important temp scripts; otherwise they can stay untracked

## See also
- Report generator: [`bin/new_report`](../bin/new_report)
- Dual‑channel workflow: `00_cursor_workflow.md`
