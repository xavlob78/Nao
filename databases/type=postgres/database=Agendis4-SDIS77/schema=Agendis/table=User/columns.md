# User

**Dataset:** `Agendis`

## Columns (10)

- id (int32 NOT NULL)
- login (string(255) NOT NULL)
- password (string(128) NOT NULL)
- block_date (date)
- virtual (boolean)
- reset_password (boolean)
- data_agendis_v3 (json)
- otp (string(6))
- otp_expires_at (timestamp(6))
- otp_try (int32)
