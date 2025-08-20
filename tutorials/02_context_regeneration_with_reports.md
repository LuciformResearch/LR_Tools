# Regenerating Context with Timestamped Reports

Reports are more than notes — they are structured context anchors. Each report includes a YAML frontmatter with `title`, `category`, `created`, `author`, and `tags` so agents can index, filter, and reload them quickly.

## Why it matters
- Fresh sessions lose in‑memory context. Reports act as durable breadcrumbs.
- Agents can scan the latest files (by timestamp) to bootstrap understanding.
- Humans keep the narrative coherent across days and branches.

## Create reports (timestamped)
```bash
# Minimal
LR_Tools/bin/new_report Overview "Daily Checkpoint"

# Include seconds for dense sessions
LR_Tools/bin/new_report Overview "Rapid Notes" --seconds

# With metadata
AUTHOR="You" TAGS="scope,tests,plan" LR_Tools/bin/new_report Plans "Detector Roadmap"
```

## Suggested structure inside a report
- Context snapshot (what we’re doing)
- Key decisions and rationale
- Immediate next actions (checklist)
- Links to code, PRs, and commands

## Agent bootstrap pattern
- On startup, agents list recent reports and open the top N files by timestamp.
- They parse frontmatter for tags (e.g., `scope`, `tests`, `release`) to prioritize.
- They read the first screens of each report to synthesize a concise working brief.

## Hygiene
- Prefer one topic per report; create another rather than overloading.
- Use consistent categories (`Overview`, `Plans`, `Research`, `Setup`, `CodeAgentTutorial`).
- Keep titles short; tags power search and filtering.
