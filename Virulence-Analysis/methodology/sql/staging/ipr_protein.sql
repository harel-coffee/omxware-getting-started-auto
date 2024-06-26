@sql/settings.sql;

DROP TABLE IF EXISTS IPR_PROTEIN_STAGING;

CREATE TABLE IPR_PROTEIN_STAGING (
  IPR_ACCESSION STRING,
  PROTEIN_UID_KEY STRING)
    USING csv
    OPTIONS (
      header false,
      path '${data_dir}/ipr_protein.csv');

CACHE TABLE IPR_PROTEIN_STAGING;

SELECT
  COUNT(1) AS NUM_ROWS,
  COUNT(DISTINCT IPR_ACCESSION) AS NUM_DISTINCT_IPRS,
  COUNT(DISTINCT PROTEIN_UID_KEY) AS NUM_DISTINCT_PROTEINS
  FROM
    IPR_PROTEIN_STAGING;
