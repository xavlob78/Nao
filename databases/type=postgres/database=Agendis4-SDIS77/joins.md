#Relations entre tables postgres/Agendis

| Relation | Table gauche | Table droite | Colonnes |
|----------|--------------|--------------|----------|
| ActiviteParametrage | Activite | ActiviteParametrage | id_activite_parametrage ↔ id |
| ActiviteUf | Activite | UniteFonctionnelle | id_unite_fonctionnelle ↔ id |
| ActiviteTranche | Activite | TrancheHoraire | id_tranche_horaire ↔ id |
| ActiviteUser | Activite | UserFiche | id_user ↔ id |