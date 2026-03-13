# Requêtes vérifiées — Fidélité COMO BFS

Ce document recense les requêtes SQL vérifiées du modèle Fidélité COMO. Chaque entrée associe une question métier à la requête SQL correspondante.

---

## 1. Part du CA Fidélité sur le Total (Hippopotamus, octobre 2025)

**Question** : Quel est la part du CA Fidélité sur le Total pour l'enseigne Hippopotamus en Octobre 2025 ?

| Métadonnée | Valeur |
|------------|--------|
| Vérifié par | Xavier Thoraval |
| Question d'onboarding | Non |

```sql
WITH ca_fidelite AS (
  SELECT
    r.pkrestaurant,
    DATE_TRUNC('MONTH', p.created_on) AS mois,
    SUM(p.cafid) AS ca_fidelite
  FROM
    fact_purchase_como AS p
    INNER JOIN dim_clients_como AS c ON p.membership_key_str = c.membership_key_str
    LEFT OUTER JOIN restaurants AS r ON p.branch_id = r.pkrestaurant
  WHERE
    r.enseigne = 'Hippopotamus'
    AND c.fraudeur = FALSE
    AND DATE_TRUNC('MONTH', p.created_on) = '2025-10-01'
  GROUP BY
    r.pkrestaurant,
    DATE_TRUNC('MONTH', p.created_on)
),
ca_total AS (
  SELECT
    r.pkrestaurant,
    DATE_TRUNC('MONTH', v.pkdate) AS mois,
    SUM(v.tot_net_revenue_ttc) AS ca_total
  FROM
    fact_ventes_bf AS v
    LEFT OUTER JOIN restaurants AS r ON v.pkrestaurant = r.pkrestaurant
  WHERE
    r.enseigne = 'Hippopotamus'
    AND DATE_TRUNC('MONTH', v.pkdate) = '2025-10-01'
  GROUP BY
    r.pkrestaurant,
    DATE_TRUNC('MONTH', v.pkdate)
)
SELECT
  SUM(cf.ca_fidelite) AS total_ca_fidelite,
  SUM(ct.ca_total) AS total_ca_total,
  SUM(cf.ca_fidelite) / NULLIF(NULLIF(SUM(ct.ca_total), 0), 0) AS part_ca_fidelite
FROM
  ca_fidelite AS cf FULL
  OUTER JOIN ca_total AS ct ON cf.pkrestaurant = ct.pkrestaurant
  AND cf.mois = ct.mois
```

---

## 2. Nombre de nouveaux clients par enseigne (décembre 2025)

**Question** : Quel est le nombre de nouveaux clients sur Décembre 2025 par enseigne ?

| Métadonnée | Valeur |
|------------|--------|
| Vérifié par | USR_LLM_X |

```sql
SELECT
  r.pkrestaurant,
  r.enseigne,
  r.nomdurestaurant,
  SUM(c.flgnouveau) AS nouveaux_clients
FROM
  dim_clients_como AS c
  LEFT OUTER JOIN restaurants AS r ON c.branch_id = r.pkrestaurant
WHERE
  c.fraudeur = FALSE
  AND DATE_TRUNC('MONTH', c.created_on) = '2025-12-01'
GROUP BY
  ALL
ORDER BY
  nouveaux_clients DESC NULLS LAST
```

---

## 3. Nouveaux inscrits par mois (depuis juillet 2025)

**Question** : Quel est le nombre de nouveaux inscrits par mois depuis Juillet 2025 ?

| Métadonnée | Valeur |
|------------|--------|
| Vérifié par | Xavier Thoraval |

```sql
SELECT
  DATE_TRUNC('MONTH', c.created_on) AS mois,
  SUM(c.flgnouvelinscrit) AS nouveaux_inscrits
FROM
  dim_clients_como AS c
WHERE
  c.fraudeur = FALSE
  AND c.created_on >= '2025-07-01'
GROUP BY
  DATE_TRUNC('MONTH', c.created_on)
ORDER BY
  mois DESC NULLS LAST
```

---

## 4. Panier moyen Fid

**Question** : Quel est le panier moyen Fid ?

| Métadonnée | Valeur |
|------------|--------|
| Vérifié par | Xavier Thoraval |

```sql
SELECT
  SUM(p.cafid) / NULLIF(COUNT(p.uid), 0) AS panier_moyen_fid
FROM
  fact_purchase_como AS p
  LEFT OUTER JOIN dim_clients_como AS c ON p.membership_key_str = c.membership_key_str
WHERE
  c.fraudeur = FALSE
```

---

## 5. Restaurants où CA Moyen Fid > CA Moyen Total

**Question** : Quels sont les tops restaurants dont le CA Moyen fid est plus gros que le CA Moyen Total ?

| Métadonnée | Valeur |
|------------|--------|
| Vérifié par | Xavier Thoraval |

```sql
WITH ca_fid_par_restaurant AS (
  SELECT
    r.pkrestaurant,
    r.enseigne,
    r.nomdurestaurant,
    SUM(p.cafid) / NULLIF(
      NULLIF(COUNT(DISTINCT p.membership_key_str), 0),
      0
    ) AS ca_moyen_fid
  FROM
    fact_purchase_como AS p
    LEFT OUTER JOIN dim_clients_como AS c ON p.membership_key_str = c.membership_key_str
    LEFT OUTER JOIN restaurants AS r ON p.branch_id = r.pkrestaurant
  WHERE
    c.fraudeur = FALSE
  GROUP BY
    r.pkrestaurant,
    r.enseigne,
    r.nomdurestaurant
),
ca_total_par_restaurant AS (
  SELECT
    r.pkrestaurant,
    r.enseigne,
    r.nomdurestaurant,
    SUM(v.tot_net_revenue_ttc) / NULLIF(NULLIF(SUM(v.nbcouverts), 0), 0) AS ca_moyen_total
  FROM
    fact_ventes_bf AS v
    LEFT OUTER JOIN restaurants AS r ON v.pkrestaurant = r.pkrestaurant
  GROUP BY
    r.pkrestaurant,
    r.enseigne,
    r.nomdurestaurant
)
SELECT
  cf.pkrestaurant,
  cf.enseigne,
  cf.nomdurestaurant,
  cf.ca_moyen_fid,
  ct.ca_moyen_total
FROM
  ca_fid_par_restaurant AS cf
  LEFT OUTER JOIN ca_total_par_restaurant AS ct ON cf.pkrestaurant = ct.pkrestaurant
WHERE
  cf.ca_moyen_fid > ct.ca_moyen_total
ORDER BY
  cf.ca_moyen_fid DESC NULLS LAST
```

---

## 6. CA Fid — Léon Aéroville, octobre 2025

**Question** : Quel est le CA Fid pour Léon Aéroville en octobre 2025 ?

| Métadonnée | Valeur |
|------------|--------|
| Vérifié par | Xavier Thoraval |

```sql
SELECT
  r.pkrestaurant,
  r.enseigne,
  r.nomdurestaurant,
  SUM(p.cafid) AS ca_fidelite
FROM
  fact_purchase_como AS p
  INNER JOIN dim_clients_como AS c ON p.membership_key_str = c.membership_key_str
  LEFT OUTER JOIN restaurants AS r ON p.branch_id = r.pkrestaurant
WHERE
  r.enseigne = 'Léon'
  AND r.nomdurestaurant LIKE '%Aeroville%'
  AND c.fraudeur = FALSE
  AND DATE_TRUNC('MONTH', p.created_on) = '2025-10-01'
GROUP BY
  r.pkrestaurant,
  r.enseigne,
  r.nomdurestaurant
```

---

## 7. Fréquentation entre 1ère et 2ème, 2ème et 3ème, 3ème et 4ème visite

**Question** : Quelle est la fréquentation de visite des clients fid ? Entre la première et la deuxième visite ? Entre la deuxième et la troisième ? Entre la troisième et la quatrième visite ?

| Métadonnée | Valeur |
|------------|--------|
| Vérifié par | Xavier Thoraval |

```sql
WITH client_visits AS (
  SELECT
    p.membership_key_str,
    TO_DATE(p.created_on) AS visit_date,
    ROW_NUMBER() OVER (
      PARTITION BY p.membership_key_str
      ORDER BY
        p.created_on
    ) AS visit_rank
  FROM
    fact_purchase_como AS p
    INNER JOIN dim_clients_como AS c ON p.membership_key_str = c.membership_key_str
  WHERE
    c.fraudeur = FALSE
),
visit_intervals AS (
  SELECT
    v1.membership_key_str,
    v1.visit_date AS visit1_date,
    v2.visit_date AS visit2_date,
    v3.visit_date AS visit3_date,
    v4.visit_date AS visit4_date,
    DATEDIFF(DAY, v1.visit_date, v2.visit_date) AS days_between_1_and_2,
    DATEDIFF(DAY, v2.visit_date, v3.visit_date) AS days_between_2_and_3,
    DATEDIFF(DAY, v3.visit_date, v4.visit_date) AS days_between_3_and_4
  FROM
    client_visits AS v1
    LEFT OUTER JOIN client_visits AS v2 ON v1.membership_key_str = v2.membership_key_str
    AND v2.visit_rank = 2
    LEFT OUTER JOIN client_visits AS v3 ON v1.membership_key_str = v3.membership_key_str
    AND v3.visit_rank = 3
    LEFT OUTER JOIN client_visits AS v4 ON v1.membership_key_str = v4.membership_key_str
    AND v4.visit_rank = 4
  WHERE
    v1.visit_rank = 1
)
SELECT
  'Entre 1ère et 2ème visite' AS periode,
  AVG(days_between_1_and_2) AS jours_moyens,
  COUNT(days_between_1_and_2) AS nombre_clients
FROM
  visit_intervals
WHERE
  NOT days_between_1_and_2 IS NULL
UNION ALL
SELECT
  'Entre 2ème et 3ème visite' AS periode,
  AVG(days_between_2_and_3) AS jours_moyens,
  COUNT(days_between_2_and_3) AS nombre_clients
FROM
  visit_intervals
WHERE
  NOT days_between_2_and_3 IS NULL
UNION ALL
SELECT
  'Entre 3ème et 4ème visite' AS periode,
  AVG(days_between_3_and_4) AS jours_moyens,
  COUNT(days_between_3_and_4) AS nombre_clients
FROM
  visit_intervals
WHERE
  NOT days_between_3_and_4 IS NULL
ORDER BY
  periode
```

---

## 8. Bons générés et utilisés — Restaurant O0110, novembre

**Question** : Combien de bons de réduction utilisés et de bons générés en Novembre dans le restaurant O0110 ?

| Métadonnée | Valeur |
|------------|--------|
| Vérifié par | Xavier Thoraval |

```sql
WITH bons_generes AS (
  SELECT
    r.pkrestaurant,
    r.enseigne,
    r.nomdurestaurant,
    COUNT(a.asset_key_str) AS nombre_bons_generes
  FROM
    fact_asset_como AS a
    LEFT OUTER JOIN dim_clients_como AS c ON a.membership_key_str = c.membership_key_str
    LEFT OUTER JOIN restaurants AS r ON a.branch_id = r.pkrestaurant
  WHERE
    c.fraudeur = FALSE
    AND DATE_TRUNC('MONTH', a.createdon) = '2025-11-01'
    AND r.pkrestaurant = 'O0110'
  GROUP BY
    r.pkrestaurant,
    r.enseigne,
    r.nomdurestaurant
),
bons_utilises AS (
  SELECT
    r.pkrestaurant,
    r.enseigne,
    r.nomdurestaurant,
    COUNT(a.asset_key_str) AS nombre_bons_utilises
  FROM
    fact_asset_como AS a
    LEFT OUTER JOIN dim_clients_como AS c ON a.membership_key_str = c.membership_key_str
    LEFT OUTER JOIN restaurants AS r ON a.redeem_purchase_branch_id = r.pkrestaurant
  WHERE
    c.fraudeur = FALSE
    AND NOT a.burnedon IS NULL
    AND DATE_TRUNC('MONTH', a.burnedon) = '2025-11-01'
    AND r.pkrestaurant = 'O0110'
  GROUP BY
    r.pkrestaurant,
    r.enseigne,
    r.nomdurestaurant
)
SELECT
  COALESCE(bg.pkrestaurant, bu.pkrestaurant) AS pkrestaurant,
  COALESCE(bg.enseigne, bu.enseigne) AS enseigne,
  COALESCE(bg.nomdurestaurant, bu.nomdurestaurant) AS nomdurestaurant,
  COALESCE(bg.nombre_bons_generes, 0) AS nombre_bons_generes,
  COALESCE(bu.nombre_bons_utilises, 0) AS nombre_bons_utilises
FROM
  bons_generes AS bg FULL
  OUTER JOIN bons_utilises AS bu ON bg.pkrestaurant = bu.pkrestaurant
```

---

## 9. Bons invalidés et points perdus

**Question** : Combien de bons de réduction invalidés ? Combien de points perdus par cette invalidation ?

| Métadonnée | Valeur |
|------------|--------|
| Vérifié par | Xavier Thoraval |

```sql
SELECT
  COUNT(a.asset_key_str) AS nombre_bons_invalides,
  SUM(da.points) AS points_perdus
FROM
  fact_asset_como AS a
  LEFT OUTER JOIN dim_assets AS da ON a.asset_template = da.id
  LEFT OUTER JOIN dim_clients_como AS c ON a.membership_key_str = c.membership_key_str
WHERE
  c.fraudeur = FALSE
  AND a.flginvalide = TRUE
```

---

## 10. Nouveaux inscrits — Restaurant S0030 (restaurant d’adhésion)

**Question** : Combien de nouveaux inscrits pour le restaurant S0030 ?

**Note** : Pour les « nouveaux », se baser sur le restaurant d’adhésion (`branch_id`).

| Métadonnée | Valeur |
|------------|--------|
| Vérifié par | USR_LLM_X |

```sql
SELECT
  r.pkrestaurant,
  r.enseigne,
  r.nomdurestaurant,
  MIN(c.created_on) AS start_date,
  MAX(c.created_on) AS end_date,
  SUM(c.flgnouvelinscrit) AS nouveaux_inscrits
FROM
  dim_clients_como AS c
  LEFT OUTER JOIN restaurants AS r ON c.branch_id = r.pkrestaurant
WHERE
  c.fraudeur = FALSE
  AND r.pkrestaurant = 'S0030'
GROUP BY
  ALL
```

---

## 11. Solde de points — Restaurant S0010

**Question** : Quel est le solde de points pour le restaurant S0010 ?

| Métadonnée | Valeur |
|------------|--------|
| Vérifié par | USR_LLM_X |

```sql
SELECT
  r.pkrestaurant,
  r.enseigne,
  r.nomdurestaurant,
  MIN(s.pkdate) AS start_date,
  MAX(s.pkdate) AS end_date,
  SUM(s.solde) AS solde_total_points
FROM
  fact_solde_como AS s
  LEFT OUTER JOIN dim_clients_como AS c ON s.membership_key_str = c.membership_key_str
  LEFT OUTER JOIN restaurants AS r ON c.restaurantaffectation = r.pkrestaurant
WHERE
  c.fraudeur = FALSE
  AND s.flgencours = TRUE
  AND r.pkrestaurant = 'S0010'
GROUP BY
  ALL
```

---

## 12. Solde de clients — Restaurant S0010

**Question** : Quel est le solde de clients pour le restaurant S0010 ?

| Métadonnée | Valeur |
|------------|--------|
| Vérifié par | USR_LLM_X |

```sql
SELECT
  r.pkrestaurant,
  r.enseigne,
  r.nomdurestaurant,
  MIN(s.pkdate) AS start_date,
  MAX(s.pkdate) AS end_date,
  SUM(s.solde) AS solde_total_points
FROM
  fact_solde_como AS s
  LEFT OUTER JOIN dim_clients_como AS c ON s.membership_key_str = c.membership_key_str
  LEFT OUTER JOIN restaurants AS r ON c.restaurantaffectation = r.pkrestaurant
WHERE
  c.fraudeur = FALSE
  AND s.flgencours = TRUE
  AND r.pkrestaurant = 'S0010'
GROUP BY
  ALL
```

---

## 13. Part des paiements en espèces (année 2026)

**Question** : Quelle est la part des paiements en espèces sur le total des paiements pour l'année 2026 ?

| Métadonnée | Valeur |
|------------|--------|
| Vérifié par | USR_LLM_X |

```sql
WITH paiements_2026 AS (
  SELECT
    pm.payment_type,
    SUM(pm.payment_sum) AS montant_paiement
  FROM
    fact_payment_como AS pm
    LEFT OUTER JOIN fact_purchase_como AS p ON pm.uid = p.uid
    LEFT OUTER JOIN dim_clients_como AS c ON p.membership_key_str = c.membership_key_str
  WHERE
    c.fraudeur = FALSE
    AND DATE_PART('YEAR', p.datefacture) = 2026
  GROUP BY
    pm.payment_type
),
total_paiements AS (
  SELECT
    SUM(montant_paiement) AS total
  FROM
    paiements_2026
),
paiements_especes AS (
  SELECT
    SUM(montant_paiement) AS especes
  FROM
    paiements_2026
  WHERE
    payment_type IN ('ESPECE', 'ESPECES', 'CASH')
)
SELECT
  pe.especes AS paiements_especes,
  tp.total AS total_paiements,
  pe.especes / NULLIF(NULLIF(tp.total, 0), 0) AS part_especes
FROM
  paiements_especes AS pe
  CROSS JOIN total_paiements AS tp
```

---

## 14. Clients inscrits actifs AUB (juillet 2025 – janvier 2026)

**Question** : Combien de clients inscrits actifs AUB entre le 01 Juillet 2025 et le 31 Janvier 2026 ?

| Métadonnée | Valeur |
|------------|--------|
| Vérifié par | USR_LLM_X |

```sql
SELECT
  COUNT(DISTINCT p.membership_key_str) AS clients_inscrits_actifs
FROM
  fact_purchase_como AS p
  INNER JOIN dim_clients_como AS c ON p.membership_key_str = c.membership_key_str
  LEFT OUTER JOIN restaurants AS r ON p.branch_id = r.pkrestaurant
WHERE
  c.fraudeur = FALSE
  AND c.flgnouvelinscrit = TRUE
  AND r.enseigne = 'Au Bureau'
  AND p.datefacture >= '2025-07-01'
  AND p.datefacture <= '2026-01-31'
```

---

## 15. Primo acheteurs AUB et multi-enseigne (juillet 2025 – janvier 2026)

**Question** : Parmi les clients inscrits actifs AUB entre le 01 Juillet 2025 et le 31 Janvier 2026, combien sont des primo acheteurs Au Bureau (premier achat chez AUB), et parmi eux combien sont multi-enseigne (achats dans d’autres enseignes) ?

| Métadonnée | Valeur |
|------------|--------|
| Vérifié par | USR_LLM_X |

```sql
WITH clients_actifs_aub AS (
  SELECT
    DISTINCT p.membership_key_str
  FROM
    fact_purchase_como AS p
    INNER JOIN dim_clients_como AS c ON p.membership_key_str = c.membership_key_str
    LEFT OUTER JOIN restaurants AS r ON p.branch_id = r.pkrestaurant
  WHERE
    c.fraudeur = FALSE
    AND c.flgnouvelinscrit = TRUE
    AND r.enseigne = 'Au Bureau'
    AND p.datefacture >= '2025-07-01'
    AND p.datefacture <= '2026-01-31'
),
primo_acheteurs_aub AS (
  SELECT
    ca.membership_key_str
  FROM
    clients_actifs_aub AS ca
    INNER JOIN dim_clients_como AS c ON ca.membership_key_str = c.membership_key_str
    LEFT OUTER JOIN restaurants AS r ON c.restaurantaffectation = r.pkrestaurant
  WHERE
    r.enseigne = 'Au Bureau'
),
multi_enseignes AS (
  SELECT
    DISTINCT pa.membership_key_str
  FROM
    primo_acheteurs_aub AS pa
    INNER JOIN fact_purchase_como AS p ON pa.membership_key_str = p.membership_key_str
    LEFT OUTER JOIN restaurants AS r ON p.branch_id = r.pkrestaurant
  WHERE
    r.enseigne <> 'Au Bureau'
)
SELECT
  (
    SELECT
      COUNT(*)
    FROM
      primo_acheteurs_aub
  ) AS primo_acheteurs_au_bureau,
  (
    SELECT
      COUNT(*)
    FROM
      multi_enseignes
  ) AS primo_acheteurs_multi_enseignes
```

---

## 16. Nouveaux clients actifs AUB — Janvier

**Question** : Combien de nouveaux clients actifs chez AUB en Janvier ?

| Métadonnée | Valeur |
|------------|--------|
| Vérifié par | USR_LLM_X |

```sql
SELECT
  COUNT(DISTINCT p.membership_key_str) AS nouveaux_clients_actifs
FROM
  fact_purchase_como AS p
  INNER JOIN dim_clients_como AS c ON p.membership_key_str = c.membership_key_str
  LEFT OUTER JOIN restaurants AS r ON p.branch_id = r.pkrestaurant
WHERE
  c.fraudeur = FALSE
  AND c.flgnouveau = TRUE
  AND r.enseigne = 'Au Bureau'
  AND DATE_TRUNC('MONTH', p.datefacture) = '2026-01-01'
```
