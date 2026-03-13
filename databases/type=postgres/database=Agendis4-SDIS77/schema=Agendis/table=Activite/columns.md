# Activite

**Dataset:** `Agendis`

## Columns (18)

- id (int32 NOT NULL)
- id_user (int32 NOT NULL)
- id_activite_parametrage (int32 NOT NULL)
- id_unite_fonctionnelle (int32 NOT NULL)
- date_debut (timestamp(6) NOT NULL)
- date_fin (timestamp(6) NOT NULL)
- est_its (boolean NOT NULL)
- commentaire (string(500))
- data_agendis_v3 (json)
- est_supprime (boolean NOT NULL)
- est_affiche (boolean NOT NULL)
- id_tranche_horaire (int32 NOT NULL)
- circuit (json)
- code_statut (string(50))
- etape_circuit (string(50))
- id_emploi (int32 NOT NULL)
- temps_travail (int32)
- temps_presence (int32)
