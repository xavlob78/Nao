# Absence

**Dataset:** `Agendis`

## Columns (15)

- id (int32 NOT NULL)
- id_absence_parametrage (int32)
- id_user (int32 NOT NULL)
- id_evenement (int32)
- date_debut (timestamp(6) NOT NULL)
- date_fin (timestamp(6) NOT NULL)
- duree (int32)
- piece_jointe (string(255))
- commentaire (string(510))
- data_agendis_v3 (json)
- est_supprime (boolean NOT NULL)
- circuit (json)
- code_statut (string(50))
- etape_circuit (string(50))
- temps_travail (int32)
