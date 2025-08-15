---
title: "Pourquoi un Listener FIFO ? (pour devs Discord)"
category: "CodeAgentTutorial"
created: 2025-08-13T00:00:00Z
author: "Cursor Via Lucie Defraiteur"
tags: ['e2e', 'fifo', 'terminal', 'devrel', 'discord']
---

# Pourquoi un Listener FIFO ? (pour devs Discord)

## TL;DR
- Un listener FIFO permet d’exécuter des commandes dans un terminal « témoin » depuis un autre process (ou un agent) sans se battre avec les caprices des PTY.
- Idéal pour des démos E2E où un humain voit clairement les étapes, les sorties, et les statuts.

## Problème (sans FIFO)
- Injection PTY directe fragile: modes « bracketed paste », différences CR/LF, restrictions TIOCSTI, latences, focus.
- Résultat: commandes parfois non exécutées, prompt collé, rendu illisible.

## Solution
- Démarrer une petite « boucle » côté terminal (listener) qui lit une FIFO et exécute `bash -lc "<cmd>"`.
- Les commandes sont envoyées par un exécuteur (injecteur) qui écrit dans la FIFO.
- Le terminal affiche la sortie « comme si » l’humain tapait la commande, mais c’est fiable et scriptable.

## Bénéfices pour les devs
- Lisibilité humaine: on voit les commandes, les sorties, et un marqueur de fin (`__DONE__ rc=<code>`).
- Débogage simple: on peut `tail -f` un log ou rejouer des scénarios.
- Automatisation « safe »: aucun bricolage CR/LF/TTY requis côté agent.
- Compatible demo/stream: terminal propre pour montrer des workflows.

## Usage dans ce repo
- Lancer le listener dans le terminal observé:
  ```bash
  python shadeos_start_listener.py
  ```
- Envoyer des commandes depuis un autre terminal:
  ```bash
  python shadeos_term_exec.py --cmd "echo '[PING]' && date -Iseconds"
  ```
- Pattern lisible recommandé pour E2E:
  ```bash
  python shadeos_term_exec.py --cmd "echo '===== TEST E2E-001 BEGIN =====' && <ta_commande> && echo '===== TEST E2E-001 END (rc=$?) ====='"
  ```

## Quand l’utiliser
- Démos publiques, revues d’équipe, tutoriels vidéo.
- Tests E2E manuels validés par un humain.
- Orchestration d’agents qui doivent montrer leurs actions en « temps réel ».

## Limites
- Nécessite de lancer le listener au début de la session.
- Un seul lecteur par FIFO (les scripts gèrent l’exclusivité).

## Bonnes pratiques
- Un seul listener par FIFO; sinon, purger l’ancien.
- Préfixer les étapes par `echo` et ajouter des délimiteurs BEGIN/END.
- Centraliser les chemins d’output et les lier dans les messages.
