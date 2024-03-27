CACHE TABLE IPR;

CACHE TABLE IPR_PROTEIN_STAGING;

CACHE TABLE GENOME_PROTEIN;

DROP TABLE IF EXISTS IPR_PROTEIN;

CREATE TABLE IPR_PROTEIN
  USING PARQUET
  AS
  SELECT
    B.IPR_ACCESSION,
    B.PROTEIN_UID_KEY
    FROM
      IPR A
      INNER JOIN IPR_PROTEIN_STAGING B ON
        B.IPR_ACCESSION = A.IPR_ACCESSION
      INNER JOIN GENOME_PROTEIN C ON
        C.PROTEIN_UID_KEY = B.PROTEIN_UID_KEY
      GROUP BY
        B.IPR_ACCESSION,
        B.PROTEIN_UID_KEY;

CACHE TABLE IPR_PROTEIN;

SELECT
  COUNT(1) AS NUM_ROWS,
  COUNT(DISTINCT IPR_ACCESSION) AS NUM_DISTINCT_IPRS,
  COUNT(DISTINCT PROTEIN_UID_KEY) AS NUM_DISTINCT_PROTEINS
  FROM
    IPR_PROTEIN;

SELECT *
  FROM
    IPR_PROTEIN
    ORDER BY 1
    LIMIT 10;

DROP TABLE IPR_PROTEIN_STAGING;