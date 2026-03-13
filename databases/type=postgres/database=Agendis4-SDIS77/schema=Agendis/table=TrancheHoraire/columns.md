# TrancheHoraire

**Dataset:** `Agendis`

## Columns (15)

- id (int32 NOT NULL)
- libelle (string(50) NOT NULL)
- code (string(1))
- description (string(255))
- est_avec_pause (boolean)
- est_selon_horaire_centre (boolean)
- heure_debut (int32)
- heure_fin (int32)
- position_debut_centre (int32)
- duree (int32)
- heure_debut_pause (int32)
- heure_fin_pause (int32)
- est_supprime (boolean)
- data_agendis_v3 (json)
- est_creneau (boolean NOT NULL)
