CACHE TABLE GENOME_TABLE_STAGING;

CACHE TABLE GENOME_PROTEIN;

DROP TABLE IF EXISTS GENOME_TABLE;

CREATE TABLE GENOME_TABLE
  USING PARQUET
  AS
  SELECT
    A.GENUS_NAME,
    A.ACCESSION_NUMBER
    FROM
      GENOME_TABLE_STAGING A
      INNER JOIN GENOME_PROTEIN B ON
        B.ACCESSION_NUMBER = A.ACCESSION_NUMBER
      GROUP BY
        A.GENUS_NAME,
        A.ACCESSION_NUMBER;

CACHE TABLE GENOME_TABLE;

SELECT
  COUNT(1) AS NUM_ROWS,
  COUNT(DISTINCT GENUS_NAME) AS NUM_DISTINCT_GENERA,
  COUNT(DISTINCT ACCESSION_NUMBER) AS NUM_DISTINCT_GENOMES
  FROM
    GENOME_TABLE;

SELECT *
  FROM
    GENOME_TABLE
      ORDER BY
        ACCESSION_NUMBER
      LIMIT 10;

DROP TABLE GENOME_TABLE_STAGING;
