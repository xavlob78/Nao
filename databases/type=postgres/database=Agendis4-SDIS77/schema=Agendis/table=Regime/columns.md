# Regime

**Dataset:** `Agendis`

## Columns (16)

- id (int32 NOT NULL)
- id_parent (int32 NOT NULL)
- rang (int32 NOT NULL)
- libelle (string(100) NOT NULL)
- unite (string(1))
- base_temps_travail (int32)
- complement_temps_travail (int32)
- base_temps_presence (int32)
- complement_temps_presence (int32)
- duree_journee_type (int32)
- heure_debut_journee (int32)
- heure_fin_journee (int32)
- description (string)
- code_flux (string(255))
- est_supprime (boolean)
- data_agendis_v3 (json)
