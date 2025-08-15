---
title: "E2E Testing avec Listener FIFO (validation humaine)"
category: "CodeAgentTutorial"
created: 2025-08-13T00:00:00Z
author: "Cursor Via Lucie Defraiteur"
tags: ['e2e', 'testing', 'terminal', 'fifo', 'agents']
---

# E2E Testing avec Listener FIFO (validation humaine)

Ce tutoriel décrit une méthode robuste pour piloter des tests E2E depuis un agent tout en gardant une validation humaine claire dans un terminal observé. On utilise un listener FIFO (ShadeOS) qui exécute des commandes reçues et reflète la sortie dans le terminal.

## Pré-requis
- Linux avec accès à `/proc` et PTY.
- Python 3.
- Ce dépôt avec scripts à la racine:
  - `shadeos_start_listener.py` (démarrage listener)
  - `shadeos_term_listener.py` (listener FIFO)
  - `shadeos_term_exec.py` (wrapper) et `tools/terminal_injection/shadeos_term_exec.py` (cible)

## Démarrage du listener (dans le terminal observé)
```bash
python shadeos_start_listener.py
# Optionnel: FIFO personnalisé
SHADEOS_FIFO=/tmp/mon_fifo python shadeos_start_listener.py
```
- Écrit l’état dans `~/.shadeos_listener.json`.
- Affiche `READY` et "Listening on FIFO..." si tout est ok.
- Préserve la lisibilité du prompt humain automatiquement grâce aux options activées par défaut:
  - `--post-ctrl-c`: envoie un Ctrl-C après la commande pour revenir au prompt
  - `--inject-enter`: injecte un Enter (ioctl TIOCSTI) pour forcer le retour au début de ligne

## Envoyer des commandes (depuis un autre terminal ou un agent)
```bash
python shadeos_term_exec.py --cmd "echo 'HELLO $(date -Iseconds)'"
# ou directement la cible rangée
python tools/terminal_injection/shadeos_term_exec.py --fifo /tmp/shadeos_cmd.fifo --cmd "echo 'HELLO $(date -Iseconds)'"
```
- Le terminal observé affiche la commande (echo) et un marqueur de fin `__DONE__ rc=<code>`.

### Si le prompt reste collé (renforcer côté exécuteur)
Le listener gère déjà le retour propre; si nécessaire, ajoute côté exécuteur:
```bash
python tools/terminal_injection/shadeos_term_exec.py \
  --fifo /tmp/shadeos_cmd.fifo \
  --wake \
  --enter-times 2 \
  --cmd "echo 'HELLO $(date -Iseconds)'"
```
- `--wake`: Ctrl-C avant la commande (ramène au prompt)
- `--enter-times N`: ajoute N Enter après la commande
- `--enter-cr`: utilise CR au lieu de LF si ton terminal l’exige

## Convention de formatage pour tests E2E lisibles
- Délimiteurs standards:
  - Début test: `===== TEST <id> BEGIN =====`
  - Fin test:   `===== TEST <id> END (rc=<code>) =====`
- Liens/chemins pertinents affichés à l’écran pour revue rapide:
  - Fichier d’output CSV: `outputs/jobs.csv`
  - Rapport généré: chemin dans `Reports/**`
- Numérotation: `<id>` peut être un entier séquentiel ou un tag (ex: E2E-001).

### Exemple: run pipeline complet avec délimiteurs et logs
```bash
python tools/terminal_injection/shadeos_term_exec.py --fifo /tmp/shadeos_cmd.fifo --cmd "echo '===== TEST E2E-001 BEGIN =====' && python -m app.cli collect --greenhouse-board notion && python -m app.cli process --input-path outputs/jobs_raw.jsonl --csv-path outputs/jobs.csv && echo 'CSV: outputs/jobs.csv' && echo '===== TEST E2E-001 END (rc=$?) ====='"
```
- Dans le terminal observé, tu verras clairement le bloc de test, les sorties, et le statut final.

## Bonnes pratiques
- Préfixer chaque commande d’un `echo` décrivant l’action.
- Utiliser `|& tee -a <log>` pour journaliser si nécessaire.
- Éviter les commandes interactives; préférer des scripts idempotents.
- Garder les chemins relatifs au repo pour reproductibilité.
- Toujours préserver le prompt humain: s’appuyer sur `start_listener.sh` (avec `--post-ctrl-c` et `--inject-enter`) et, en cas de besoin, compléter avec `--wake`/`--enter-times` côté exécuteur.

## Dépannage
- Si "Listener not found": relancer `./start_listener.sh` dans le terminal cible.
- Si rien ne s’affiche: vérifier la FIFO (variable `SHADEOS_FIFO`) et les permissions du TTY.
