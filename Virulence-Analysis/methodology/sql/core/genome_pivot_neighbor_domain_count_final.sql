CACHE TABLE GENOME_TABLE;

CACHE TABLE GENUS_MINIMUM_CUTOFF_THRESHOLD;

CACHE TABLE GENUS_PIVOT_NEIGHBOR_DOMAIN_COUNT_FINAL;

CACHE TABLE GENOME_PIVOT_NEIGHBOR_DOMAIN_COUNT;

DROP TABLE IF EXISTS GENUS_GENOME_PIVOT_NEIGHBOR_DOMAIN_COUNT;

CREATE TABLE GENUS_GENOME_PIVOT_NEIGHBOR_DOMAIN_COUNT
  USING PARQUET
  AS
  SELECT
    A.GENUS_NAME,
    B.*
    FROM
      GENOME_TABLE A
      INNER JOIN GENOME_PIVOT_NEIGHBOR_DOMAIN_COUNT B ON
        B.ACCESSION_NUMBER = A.ACCESSION_NUMBER;

CACHE TABLE GENUS_GENOME_PIVOT_NEIGHBOR_DOMAIN_COUNT;

SELECT
  COUNT(1) AS NUM_ROWS,
  COUNT(DISTINCT GENUS_NAME) AS NUM_DISTINCT_GENERA,
  COUNT(DISTINCT ACCESSION_NUMBER) AS NUM_DISTINCT_GENOMES,
  COUNT(DISTINCT PIVOT_DOMAIN_ARCHITECTURE_UID_KEY) AS NUM_DISTINCT_PIVOTS,
  COUNT(DISTINCT NEIGHBOR_DOMAIN_ARCHITECTURE_UID_KEY) AS NUM_DISTINCT_NEIGHBORS
  FROM
    GENUS_GENOME_PIVOT_NEIGHBOR_DOMAIN_COUNT;

SELECT *
  FROM
    GENUS_GENOME_PIVOT_NEIGHBOR_DOMAIN_COUNT
    LIMIT 10;

DROP TABLE IF EXISTS GENOME_PIVOT_NEIGHBOR_DOMAIN_COUNT_FINAL;

CREATE TABLE GENOME_PIVOT_NEIGHBOR_DOMAIN_COUNT_FINAL
  USING PARQUET
  AS
  SELECT
    B.ACCESSION_NUMBER,
    B.PIVOT_DOMAIN_ARCHITECTURE_UID_KEY,
    B.NEIGHBOR_DOMAIN_ARCHITECTURE_UID_KEY,
    CASE WHEN B.NEIGHBOR_TYPE = 'PD'
      THEN 'D'
      ELSE B.NEIGHBOR_TYPE
    END AS NEIGHBOR_TYPE,
    B.COUNT
    FROM
      GENOME_TABLE A
      INNER JOIN GENUS_GENOME_PIVOT_NEIGHBOR_DOMAIN_COUNT B ON
        B.GENUS_NAME = A.GENUS_NAME AND
        B.ACCESSION_NUMBER = A.ACCESSION_NUMBER
      INNER JOIN GENUS_PIVOT_NEIGHBOR_DOMAIN_COUNT_FINAL C ON
        C.GENUS_NAME = B.GENUS_NAME AND
        C.PIVOT_DOMAIN_ARCHITECTURE_UID_KEY = B.PIVOT_DOMAIN_ARCHITECTURE_UID_KEY AND
        C.NEIGHBOR_DOMAIN_ARCHITECTURE_UID_KEY = B.NEIGHBOR_DOMAIN_ARCHITECTURE_UID_KEY
      GROUP BY
        B.ACCESSION_NUMBER,
        B.PIVOT_DOMAIN_ARCHITECTURE_UID_KEY,
        B.NEIGHBOR_DOMAIN_ARCHITECTURE_UID_KEY,
        4,
        B.COUNT;

CACHE TABLE GENOME_PIVOT_NEIGHBOR_DOMAIN_COUNT_FINAL;

SELECT
  COUNT(1) AS NUM_ROWS,
  COUNT(DISTINCT ACCESSION_NUMBER) AS NUM_DISTINCT_GENOMES,
  COUNT(DISTINCT PIVOT_DOMAIN_ARCHITECTURE_UID_KEY) AS NUM_DISTINCT_PIVOTS,
  COUNT(DISTINCT NEIGHBOR_DOMAIN_ARCHITECTURE_UID_KEY) AS NUM_DISTINCT_NEIGHBORS
  FROM
    GENOME_PIVOT_NEIGHBOR_DOMAIN_COUNT_FINAL;

SELECT *
  FROM
    GENOME_PIVOT_NEIGHBOR_DOMAIN_COUNT_FINAL
    ORDER BY 1, 2
    LIMIT 20;

DROP TABLE GENUS_GENOME_PIVOT_NEIGHBOR_DOMAIN_COUNT;
