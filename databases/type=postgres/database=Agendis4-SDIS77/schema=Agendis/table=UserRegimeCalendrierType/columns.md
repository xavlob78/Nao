# UserRegimeCalendrierType

**Dataset:** `Agendis`

## Columns (16)

- id (int32 NOT NULL)
- id_user (int32 NOT NULL)
- est_valable_ferie (boolean)
- est_valable_ponts (boolean)
- credit_heure (int32)
- debit_heure (int32)
- description_jours (json)
- type_horaire (string(50))
- est_supprime (boolean)
- data_agendis_v3 (json)
- date_debut (date NOT NULL)
- date_fin (date)
- libelle (string(100) NOT NULL)
- id_regime (int32 NOT NULL)
- est_personnalise (boolean NOT NULL)
- id_calendrier_type (int32)
