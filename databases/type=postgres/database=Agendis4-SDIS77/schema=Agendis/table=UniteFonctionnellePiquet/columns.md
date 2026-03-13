# UniteFonctionnellePiquet

**Dataset:** `Agendis`

## Columns (16)

- id (int32 NOT NULL)
- id_parent (int32)
- id_unite_fonctionnelle (int32)
- libelle (string(100) NOT NULL)
- code (string(3))
- couleur (string(7))
- est_obligatoire (boolean)
- effectif_min (int32)
- effectif_max (int32)
- heure_debut (int32)
- heure_fin (int32)
- est_actif (boolean)
- is_node (boolean)
- est_supprime (boolean)
- data_agendis_v3 (json)
- ordre (int32)
