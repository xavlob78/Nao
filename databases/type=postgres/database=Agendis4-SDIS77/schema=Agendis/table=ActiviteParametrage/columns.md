# ActiviteParametrage

**Dataset:** `Agendis`

## Columns (19)

- id (int32 NOT NULL)
- id_parent (int32)
- libelle (string(200) NOT NULL)
- is_node (boolean NOT NULL)
- code (string(10))
- data_agendis_v3 (json)
- id_activite_type (int32)
- couleur (string(7))
- description (string(255))
- est_actif (boolean NOT NULL)
- est_applicable_teletravail (boolean NOT NULL)
- peut_faire_objet_trajet (boolean NOT NULL)
- est_exploitable_sirene (boolean NOT NULL)
- application_its_decompte_temps_travail (boolean NOT NULL)
- est_supprime (boolean NOT NULL)
- est_op (boolean)
- configuration_tranches_horaires (json)
- circuit (json)
- est_applicable_its (boolean)
