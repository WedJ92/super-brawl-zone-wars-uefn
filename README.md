# 🎮 Super Brawl Zone Wars — Map Fortnite (UEFN)

Map multijoueur **4v4v4v4** sur Fortnite Creative 2.0, développée avec **UEFN (Unreal Editor for Fortnite)** et scriptée en **Verse**.

## 🕹️ Jouer à la map

- **Code Île :** `8446-7668-7997`
- **Lien direct :** [fortnite.com/@WDST/8446-7668-7997](https://www.fortnite.com/@WDST/8446-7668-7997)
- **Mode :** Zone Wars, 4 équipes de 4 joueurs (16 max)
- **Règle :** Mêlée + armes spéciales uniquement
- **Date de publication :** Avril 2026

## ⚙️ Stack technique

- **UEFN** (Unreal Editor for Fortnite) — éditeur, level design, devices
- **Verse** — langage de programmation d'Epic Games (statiquement typé, orienté objet, support de l'asynchrone natif)
- **Fortnite Creative 2.0** — plateforme de publication Epic Games

## 📂 Architecture du code

Le projet est découpé en deux modules indépendants, chacun attaché à un `creative_device` distinct dans l'éditeur UEFN.

```
super-brawl-zone-wars-uefn/
├── Lobby_Selector.verse    # Gestion du lobby et de la sélection des équipes
├── Start_and_stuff.verse  # Lancement du match, téléportation et stuff aléatoire
└── README.md
```

### `Lobby_Selector.verse` — Gestion du lobby

Module responsable de la **sélection d'équipe** avant le match. Chaque équipe (Bleu / Rouge / Jaune / Vert) est associée à une `mutator_zone_device`. Quand un joueur entre dans une zone :

- Vérification du nombre de joueurs déjà dans l'équipe (max 4 par équipe).
- Si l'équipe a de la place → incrément du compteur et message HUD de confirmation.
- Si l'équipe est pleine → message HUD d'erreur.
- Quand un joueur sort de la zone → décrément du compteur.

**Concepts démontrés :** event subscription (`AgentEntersEvent` / `AgentExitsEvent`), gestion d'état mutable (`var`), messages localisés (`<localizes>`).

### `Start_and_stuff.verse` — Lancement du match

Module responsable du **démarrage de la partie**. Déclenché par un `timer_device` :

1. Récupère tous les joueurs présents dans le playspace.
2. Distribue à chacun un **équipement aléatoire** : 1 arme (parmi 10), 1 item utilitaire (parmi 8), 1 soin (parmi 7).
3. Téléporte chaque joueur sur une **plaque de spawn** correspondant à son index.
4. Met chaque joueur en **stasis** (figé, ne peut plus bouger).
5. Affiche **"READY"** sur le HUD de tous les joueurs pendant 2 secondes.
6. Affiche **"FIGHT"** pendant 1 seconde.
7. Libère tous les joueurs de la stasis → début effectif du combat.

**Concepts démontrés :** programmation **asynchrone** (`<suspends>`, `Sleep`, `spawn`), itération avec index, génération aléatoire, manipulation de personnages (téléport / stasis / release).

## 🛠️ Compétences techniques mises en pratique

- Programmation orientée objet (classes, méthodes, héritage de `creative_device`)
- Programmation événementielle (subscriptions à des événements de devices)
- Programmation asynchrone (`<suspends>`, `Sleep`, `spawn`)
- Gestion d'état mutable (`var`, opérateur `set`)
- Manipulation de collections et itération indexée
- Génération de nombres aléatoires
- Intégration éditeur ↔ code (paramètres `@editable`)
- Localisation des messages (`<localizes>`)

## 📝 À propos du projet

Premier projet de game-dev complet mené de bout en bout : conception, level design dans UEFN, scripting en Verse, tests itératifs, publication sur la plateforme Fortnite. L'objectif n'était pas commercial mais pédagogique : prendre en main un éditeur 3D professionnel et un langage de programmation typé orienté objet, tout en menant un projet jusqu'au livrable publié.

## 👤 Auteur

**Joassaint Wedjy** 

📧 wedjoa12@gmail.com
💻 [github.com/WedJ92](https://github.com/WedJ92)
📍 Boulogne-Billancourt (92100)
