# Tutoriel — Conventions d'horodatage pour les Reports

Ce projet horodate systématiquement les fichiers de `Reports` afin de préserver l'historique et éviter les conflits.

## Format de nommage
- Format pour les fichiers: `Nom_D_M_YYYY_HHh_MM.md`
- Variante avec secondes (quand nécessaire): `Nom_D_M_YYYY_HHh_MMm_SSs.md`

Exemples:
- `Project_Snapshot_13_8_2025_14h_22.md`
- `Daily_Plan_13_8_2025_14h_22.md`
- `Scraping_Pipeline_Plan_13_8_2025_14h_22m_07s.md` (avec secondes)

## Règles
- Tous les nouveaux fichiers dans `Reports/**` doivent être créés avec l'horodatage au moment de la création.
- Lors d'une mise à jour majeure, créer un nouveau fichier horodaté au lieu d'écraser l'ancien.
- Les tables de matières ou index peuvent pointer vers la version la plus récente.

## Commandes utiles (bash)

Renommer en ajoutant date/heure minute (sans secondes):
```bash
ts=$(date +%-d_%-m_%Y_%Hh_%M)
git mv "Reports/Overview/Project_Snapshot.md" "Reports/Overview/Project_Snapshot_${ts}.md"
```

Créer un fichier avec secondes dans le nom:
```bash
tssec=$(date +%-d_%-m_%Y_%Hh_%Mm_%Ss)
cat > "Reports/Research/Exemple_${tssec}.md" << 'EON'
Contenu...
EON
```

## Bonnes pratiques pour agents
- Préférer `git mv` pour conserver l'historique lors des renommages.
- Grouper les renommages dans un seul commit descriptif.
- Toujours exécuter `git status` puis `git push` après validation.
