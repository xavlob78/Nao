# AbsenceUserUniteFonctionnelle

**Dataset:** `Agendis`

## Columns (15)

- id (int32 NOT NULL)
- id_absence_parametrage (int32)
- id_user (int32 NOT NULL)
- id_evenement (int32)
- date_debut (timestamp(6) NOT NULL)
- date_fin (timestamp(6) NOT NULL)
- duree (int32)
- duree_h (int32)
- code_statut (string(50))
- etape_circuit (string(50))
- id_unite_fonctionnelle (int32 NOT NULL)
- id_emploi (int32 NOT NULL)
- debut_uu (date NOT NULL)
- fin_uu (date)
- ordre_priorite (int32)
