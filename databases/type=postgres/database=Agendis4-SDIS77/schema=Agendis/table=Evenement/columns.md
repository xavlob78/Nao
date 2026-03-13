# Evenement

**Dataset:** `Agendis`

## Columns (13)

- id (int32 NOT NULL)
- id_user (int32 NOT NULL)
- id_absence_parametrage (int32 NOT NULL)
- libelle (string(255) NOT NULL)
- solde (decimal)
- poses_restantes (int32)
- date_creation (timestamp(6) NOT NULL)
- date_modification (timestamp(6))
- date_fin (timestamp(6))
- est_supprime (boolean NOT NULL)
- data_agendis_v3 (json)
- capital (decimal)
- id_absence_capital_type_alimentation (int32)
