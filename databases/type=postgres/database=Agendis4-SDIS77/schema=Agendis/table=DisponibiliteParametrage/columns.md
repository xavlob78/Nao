# DisponibiliteParametrage

**Dataset:** `Agendis`

## Columns (13)

- id (int32 NOT NULL)
- libelle (string(100) NOT NULL)
- code (string(3) NOT NULL)
- description (string(255))
- couleur (string(7))
- est_actif (boolean)
- est_departementale (boolean NOT NULL)
- est_exploitable_sirene (boolean NOT NULL)
- id_statut_exchange (int32)
- est_supprime (boolean NOT NULL)
- data_agendis_v3 (json)
- configuration_tranches_horaires (json)
- circuit (json)
