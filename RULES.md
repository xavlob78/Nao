# Si la question est relative à la Fidélité, Como, LBA alors utilise la database snowflake-prod
# Si la question est relative au Temps de travail, Agendis alors utilise la database postgres-prod
# Si la question est relative aux Produits d'energie, EMP alors utilise la database fabric-emc


## Règles et modèle Fidélité COMO BFS

**Description** : Analyse du programme de fidélité COMO pour l'enseigne BFS. Permet de suivre l'attribution et la consommation des bons par restaurants ainsi que les factures reliées. Le programme de fidélisation s'appelle également LBA pour la bonne app.

### Règles métier et instructions

- **Comparaisons de tickets** — En cas de demande relatives à des comparaisons de tickets Total ou hors fid (ticket moyen, panier moyen, nombre de tickets), prévenir l'utilisateur que la valeur est **par couvert** et non par facture.

- **Enseignes** — Les enseignes disponibles dans le modèle sont « Léon », « Au Bureau », « Volfoni » et « Hippopotamus ». Si l'orthographe diffère, s'attacher à l'une de ces enseignes.

- **CA Fidélisation vs CA Total** — Lors de la comparaison entre le CA Fidélisation et le CA Total : agréger les données par Restaurant (ou enseigne) ET par date (ou mois, année), comparer le résultat agrégé et filtrer sur les restaurants COMO (`flgcomo = TRUE`).

- **Affichage restaurant** — Quand tu affiches un restaurant, présenter toujours son **Code** (PkRestaurant), son **Enseigne** et son **nom**.

- **Affichage client** — Quand tu affiches un client, présenter toujours son **ID** (MEMBERSHIP_KEY_STR), son **nom** (LastName) et son **email**.

- **Nouveau client** — Un nouveau client peut être un nouvel inscrit (membre) ou un nouveau client (membre client) lorsqu'il a fait un achat le jour de son inscription. Par défaut on compte les nouveaux inscrits ; sans demande spécifique on peut afficher les deux mesures.

- **Clients fraudeurs** — Sauf demande spécifique, filtrer toujours les clients fraudeurs (`FLGFRAUDE = FALSE`).

- **Restaurant lié au client** — Lorsqu'on relie le client au restaurant, choix possible entre :
  - **Restaurant d'affectation** : colonne `RestaurantAffectation` (premier restaurant visité / primo restaurant)
  - **Restaurant d'adhésion** : colonne `branch_id` de la table client (restaurant recruteur)
  - **Restaurant actif sur la période** : colonne `branch_id` de la table purchase (restaurant où il fait ses achats sur la période)
  - Utiliser le **restaurant d'adhésion** pour les nouveaux inscrits.
  - Utiliser le **restaurant d'affectation** pour les clients affectés aux restaurants.
  - Utiliser le **restaurant actif** pour les clients actifs (visite du restaurant sur la période choisie).

- **Nouveau client / client LBA** — Un nouveau client ou un client LBA est un client créé depuis le début du programme (`FLGNOUVEAU = TRUE`).

- **Jointure Factures / Clients** — La jointure entre les Factures et les Clients se fait en mode **INNER**.

- **GROUP BY** — Lorsque tu dois faire un `GROUP BY`, utiliser la syntaxe **GROUP BY ALL** sans lister les colonnes.

