# Love-2D-tiny-Chess-game

Un petit jeu d'échec écrit en Lua avec le framework Löve2D (https://love2d.org).

## Work in progress

- [x] Première architecture avec des classes pour les pièces ;
- [x] Affichage du plateau ;

![Démonstration du plateau au début du jeu](demo_plateau_initial.png)

- [x] Calcul des coups possibles pour chaque type de pièces ;
- [x] Sélection de la pièce à jouer, et de la case de destination ;
- [x] Pouvoir manger une pièce adverse, compter +1 au score, et passer au joueur adverse ;
- [x] Alternance joueur blanc, joueur noir, etc. (machine à état basique) ;
- [x] Jeu infini, jusqu'à ce qu'un Roi ait été pris ;
- [x] l'interface graphique montre de façon très basique l'alternance des joueurs ;
- [ ] TODO: faire en sorte que le joueur actif ne puisse bouger que ses pièces ;

![Démonstration du plateau en cours de jeu](demo_plateau_en_cours.png)

Et après, je veux essayer ça :

- [ ] Connecter le joueur noir à une API en ligne de commande d'un bon solveur d'échec (par exemple [stockfish](https://stockfishchess.org/) ?).

## Ce que je ne ferai pas (pas envie)

- [ ] Prise en passant ;
- [ ] Les petit et grand roques ;
- [ ] La promotion des pions ?
- [ ] Une intelligence artificielle faite maison ;

## License ?

[MIT Licensed](LICENSE)
© Lilian Besson (Naereen), 2023
