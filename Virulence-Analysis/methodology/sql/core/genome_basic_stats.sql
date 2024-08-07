CACHE TABLE GENOME_PIVOT_NEIGHBOR_DOMAIN_COUNT_FINAL;

DROP TABLE IF EXISTS GENOME_BASIC_STATS;

CREATE TABLE GENOME_BASIC_STATS
  USING PARQUET
  AS
  SELECT
    ACCESSION_NUMBER,
    NEIGHBOR_TYPE,
    SUM(COUNT) AS COUNT
    FROM
      GENOME_PIVOT_NEIGHBOR_DOMAIN_COUNT_FINAL
      GROUP BY
        ACCESSION_NUMBER,
        NEIGHBOR_TYPE;

CACHE TABLE GENOME_BASIC_STATS;

SELECT
  COUNT(1) AS NUM_ROWS,
  COUNT(DISTINCT ACCESSION_NUMBER) AS NUM_DISTINCT_GENOMES,
  COUNT(DISTINCT NEIGHBOR_TYPE) AS NUM_DISTINCT_TYPES
  FROM
    GENOME_BASIC_STATS;

SELECT *
  FROM
    GENOME_BASIC_STATS
    ORDER BY 1, 2
    LIMIT 10;
