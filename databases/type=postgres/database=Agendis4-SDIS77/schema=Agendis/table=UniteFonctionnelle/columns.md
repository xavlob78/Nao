# UniteFonctionnelle

**Dataset:** `Agendis`

## Columns (11)

- id (int32 NOT NULL)
- id_parent (int32)
- libelle (string(100) NOT NULL)
- is_node (boolean NOT NULL)
- data_agendis_v3 (json)
- est_supprime (boolean NOT NULL)
- id_unite_fonctionnelle_type (int32 NOT NULL)
- mail_chef (string(256))
- heure_debut (int32)
- code_flux (string(255))
- ordre (int32)
