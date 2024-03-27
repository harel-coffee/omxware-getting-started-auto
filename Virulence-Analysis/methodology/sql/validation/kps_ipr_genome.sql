CACHE TABLE GENOME_PROTEIN;

CACHE TABLE IPR;

CACHE TABLE IPR_PROTEIN;

CACHE TABLE KPS_GENOME_TABLE;

DROP TABLE IF EXISTS KPS_IPR_GENOME;

CREATE TABLE KPS_IPR_GENOME
  USING PARQUET
  AS
  SELECT
    C.IPR_ACCESSION || ':' || D.TYPE AS IPR_ACCESSION,
    A.ACCESSION_NUMBER
    FROM
      KPS_GENOME_TABLE A
      INNER JOIN GENOME_PROTEIN B ON
        B.ACCESSION_NUMBER = A.ACCESSION_NUMBER
      INNER JOIN IPR_PROTEIN C ON
        C.PROTEIN_UID_KEY = B.PROTEIN_UID_KEY
      INNER JOIN IPR D ON
        D.IPR_ACCESSION = C.IPR_ACCESSION;

CACHE TABLE KPS_IPR_GENOME;

SELECT
  COUNT(1) AS NUM_ROWS,
  COUNT(DISTINCT IPR_ACCESSION) AS NUM_DISTINCT_IPRS,
  COUNT(DISTINCT ACCESSION_NUMBER) AS NUM_DISTINCT_GENOMES
  FROM
    KPS_IPR_GENOME;

SELECT *
  FROM
    KPS_IPR_GENOME
    ORDER BY 1
    LIMIT 10;