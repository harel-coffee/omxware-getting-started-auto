@sql/settings.sql;

DROP TABLE IF EXISTS GENOME_PROTEIN_STAGING;

CREATE TABLE GENOME_PROTEIN_STAGING (
  ACCESSION_NUMBER STRING,
  PROTEIN_UID_KEY STRING,
  LOCUS INT)
    USING csv
    OPTIONS (
      header false,
      path '${data_dir}/genome_protein.csv');

CACHE TABLE GENOME_PROTEIN_STAGING;

SELECT
  COUNT(1) AS NUM_ROWS,
  COUNT(DISTINCT ACCESSION_NUMBER) AS NUM_DISTINCT_GENOMES,
  COUNT(DISTINCT PROTEIN_UID_KEY) AS NUM_DISTINCT_PROTEINS
  FROM
    GENOME_PROTEIN_STAGING;
