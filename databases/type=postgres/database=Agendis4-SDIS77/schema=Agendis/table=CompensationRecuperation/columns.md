# CompensationRecuperation

**Dataset:** `Agendis`

## Columns (12)

- id (int32 NOT NULL)
- libelle (string(100) NOT NULL)
- id_jour_debut (int32 NOT NULL)
- type (string(10) NOT NULL)
- est_valable_jours_feries (boolean NOT NULL)
- est_valable_ponts (boolean NOT NULL)
- est_uniquement_jours_feries (boolean NOT NULL)
- est_uniquement_ponts (boolean NOT NULL)
- description (json NOT NULL)
- est_supprime (boolean NOT NULL)
- data_agendis_v3 (json)
- est_compensation (boolean NOT NULL)
