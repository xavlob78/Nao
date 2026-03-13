# Disponibilite

**Dataset:** `Agendis`

## Columns (14)

- id (int32 NOT NULL)
- id_disponibilite_parametrage (int32 NOT NULL)
- id_tranche_horaire (int32 NOT NULL)
- id_user (int32 NOT NULL)
- id_unite_fonctionnelle (int32)
- date_debut (timestamp(6) NOT NULL)
- date_fin (timestamp(6) NOT NULL)
- commentaire (string(256))
- data_agendis_v3 (json)
- est_supprime (boolean NOT NULL)
- circuit (json)
- code_statut (string(50))
- etape_circuit (string(50))
- id_emploi (int32)
