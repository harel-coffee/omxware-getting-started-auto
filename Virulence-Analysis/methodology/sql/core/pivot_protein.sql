CACHE TABLE PROTEIN_DOMAIN_ARCHITECTURE;

CACHE TABLE PROTEIN_VIRULENCE;

DROP TABLE IF EXISTS PIVOT_PROTEIN;

CREATE TABLE PIVOT_PROTEIN
  USING PARQUET
  AS
  SELECT
    C.PROTEIN_UID_KEY
    FROM
      PROTEIN_VIRULENCE A
      INNER JOIN PROTEIN_DOMAIN_ARCHITECTURE B ON
        B.PROTEIN_UID_KEY = A.PROTEIN_UID_KEY
      INNER JOIN PROTEIN_DOMAIN_ARCHITECTURE C ON
        C.DOMAIN_ARCHITECTURE_UID_KEY = B.DOMAIN_ARCHITECTURE_UID_KEY
      GROUP BY
        C.PROTEIN_UID_KEY;

CACHE TABLE PIVOT_PROTEIN;

SELECT
  COUNT(1) AS NUM_ROWS,
  COUNT(DISTINCT PROTEIN_UID_KEY) AS NUM_DISTINCT_PROTEINS
  FROM
    PIVOT_PROTEIN;

SELECT *
  FROM
    PIVOT_PROTEIN
    ORDER BY 1
    LIMIT 10;