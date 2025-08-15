# Tutoriel — Frontmatter YAML pour Reports

Les fichiers de `Reports/**` incluent un frontmatter YAML standardisé pour faciliter l'indexation et les traitements automatiques par des agents.

## Champs
- `title`: titre humain du document
- `category`: sous-dossier de `Reports` (Overview, Plans, Research, Setup, CodeAgentTutorial)
- `created`: timestamp ISO8601
- `author`: auteur (défaut: "unknown")
- `tags`: liste de tags yml (ex: ['ai', 'agents'])

## Génération via Makefile
```bash
AUTHOR="Lucie" TAGS="ai,agents" \
make new-report NEW_REPORT_CATEGORY=Research NEW_REPORT_NAME="Notes API Greenhouse"
```

## Génération via script direct
```bash
AUTHOR="Lucie" TAGS="ai,agents,scraping" \
bin/new_report Research "Greenhouse Exploration" --seconds
```

## Bonnes pratiques
- Utiliser des tags courts, en minuscules, séparés par des virgules
- Garder `title` concis; le nom de fichier est déjà horodaté
- Ne pas supprimer le frontmatter; les agents peuvent s'y référer
