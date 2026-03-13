# CalendrierType

**Dataset:** `Agendis`

## Columns (12)

- id (int32 NOT NULL)
- id_parent (int32)
- is_node (boolean NOT NULL)
- libelle (string(100) NOT NULL)
- type_horaire (string(50))
- est_valable_ferie (boolean)
- est_valable_ponts (boolean)
- credit_heure (int32)
- debit_heure (int32)
- description_jours (json)
- est_supprime (boolean NOT NULL)
- data_agendis_v3 (json)
