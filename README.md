# LR_Tools — Luciform Research Tools

Outils utilitaires et tutoriels pour nos pipelines (terminal injection FIFO, scripts bin/install), regroupés sous un même toit.

## Contenu

- `bin/`
  - `new_report`: générateur rapide de fichier Markdown avec frontmatter (date/titre). Exemple:
    ```bash
    LR_Tools/bin/new_report "Mon Rapport" Reports/Overview
    ```
- `install/`
  - `install_cloudflare_warp.sh`, `install_cloudflare_warp2.sh`: scripts d’installation Cloudflare WARP (réseau privé sécurisé).
- `terminal_injection/`
  - `shadeos_term_listener.py`: listener FIFO contrôlant un terminal (écrit l’état dans `~/.shadeos_listener.json`).
  - `shadeos_term_exec.py`: injecteur qui envoie des commandes dans la FIFO.
- `tutorials/`
  - Guides d’utilisation (E2E listener FIFO, frontmatter, Makefile NewReport, etc.).

## Démarrage rapide — Terminal injection FIFO

1) Démarrer le listener (dans le terminal à contrôler):
```bash
python LR_Tools/shadeos_start_listener.py
# Optionnel: FIFO custom
SHADEOS_FIFO=/tmp/mon_fifo python LR_Tools/shadeos_start_listener.py
```
2) Envoyer une commande depuis un autre terminal ou un agent:
```bash
python LR_Tools/terminal_injection/shadeos_term_exec.py \
  --fifo /tmp/shadeos_cmd.fifo \
  --cmd "echo 'HELLO $(date -Iseconds)'"
```
3) Conseils (si prompt collé):
```bash
python LR_Tools/terminal_injection/shadeos_term_exec.py \
  --fifo /tmp/shadeos_cmd.fifo \
  --wake \
  --enter-times 2 \
  --cmd "echo 'HELLO'"
```

## Notes d’architecture
- `shadeos_start_listener.py` détecte dynamiquement le chemin de `LR_Tools` et du listener (ou via `SHADEOS_TOOLS_DIR`).
- Pas de secrets dans ce repo.

## Licence
Voir `LICENSE` (propriétaire Luciform Research; usage public interdit sans pacte de collaboration écrit).
