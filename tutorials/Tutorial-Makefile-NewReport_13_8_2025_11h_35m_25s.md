# Tutoriel — Génération de reports horodatés via Makefile

Ce guide explique comment créer de nouveaux fichiers Markdown horodatés dans `Reports/**` à l'aide du Makefile (portable pour tous les contributeurs du dépôt).

## Prérequis
- Bash (Linux/macOS/WSL)
- `make` installé

## Commande principale

```bash
make new-report NEW_REPORT_CATEGORY=<Overview|Plans|Research|Setup|CodeAgentTutorial> \
               NEW_REPORT_NAME="Titre du report" \
               WITH_SECONDS=1   # optionnel
```

- `NEW_REPORT_CATEGORY` (obligatoire): sous-dossier de `Reports`.
- `NEW_REPORT_NAME` (obligatoire): base du nom du fichier; caractères spéciaux seront remplacés par `_`.
- `WITH_SECONDS` (optionnel): si défini, ajoute les secondes.

## Exemples
- Créer un plan journalier:
```bash
make new-report NEW_REPORT_CATEGORY=Plans NEW_REPORT_NAME="Daily Plan"
```
- Créer une note de recherche avec secondes:
```bash
make new-report NEW_REPORT_CATEGORY=Research NEW_REPORT_NAME="Notes API Greenhouse" WITH_SECONDS=1
```

## Comment ça marche
- La cible `new-report` délègue à `bin/new_report`, qui applique la convention d'horodatage décrite dans le tutoriel principal.
- Le fichier est créé dans `Reports/<Category>/<BaseName>_D_M_YYYY_HHh_MM.md`.

## Astuce
- Liste des cibles:
```bash
make help
```
