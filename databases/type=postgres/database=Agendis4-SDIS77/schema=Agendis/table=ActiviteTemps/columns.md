# ActiviteTemps

**Dataset:** `Agendis`

## Columns (12)

- id (int32 NOT NULL)
- id_activite_parametrage (int32 NOT NULL)
- id_regime (int32 NOT NULL)
- decompte_temps_travail (int32)
- decompte_temps_presence (int32)
- est_supprime (boolean NOT NULL)
- data_agendis_v3 (json)
- id_tranche_horaire (int32)
- est_ratio_decompte_temps_travail (boolean NOT NULL)
- est_ratio_decompte_temps_presence (boolean NOT NULL)
- ratio_decompte_temps_travail (decimal(5, 3))
- ratio_decompte_temps_presence (decimal(5, 3))
