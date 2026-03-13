# ParametreApplicatif

**Dataset:** `Agendis`

## Columns (12)

- id (int32 NOT NULL)
- code (string(100) NOT NULL)
- module (string(100))
- theme (string(100))
- libelle (string(100) NOT NULL)
- description (string(255))
- parametre (string(255))
- type (string(50) NOT NULL)
- expression_reguliere (string(255))
- valeurs_possibles (json)
- est_supprime (boolean NOT NULL)
- data_agendis_v3 (json)
