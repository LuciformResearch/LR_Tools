# Makefile targets and Command Recipes

This guide shows how to define small, reliable commands you can fire repeatedly from agents.

## Makefile (example)
Create a `Makefile` with:
```Makefile
new-report:
	AUTHOR="$(AUTHOR)" TAGS="$(TAGS)" LR_Tools/bin/new_report $(NEW_REPORT_CATEGORY) "$(NEW_REPORT_NAME)" $(if $(WITH_SECONDS),--seconds,)

scope-smoke:
	PYTHONPATH=LR_ScopeDetector:LR_ScopeTools python scripts/scope_probe.py --help

unit-fast:
	pytest -q
```

Use it like:
```bash
make new-report NEW_REPORT_CATEGORY=Overview NEW_REPORT_NAME="Checkpoint" AUTHOR="You" TAGS="tests,scope"
make unit-fast
```

## Injector recipes
The injector has built‑in recipes you can tweak.
```bash
python terminal_injection/shadeos_term_exec.py --recipe unit-fast
python terminal_injection/shadeos_term_exec.py --recipe e2e --timeout-sec 120 --tee-log /tmp/e2e.log
```

## Best practices
- Keep commands simple and idempotent.
- Prefer environment variables over hard‑coded paths.
- Centralize common flags in Make targets.
