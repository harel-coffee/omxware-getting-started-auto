CACHE TABLE GENUS_MINIMUM_CUTOFF_THRESHOLD;

CACHE TABLE GENUS_PIVOT_NEIGHBOR_DOMAIN_COUNT;

DROP TABLE IF EXISTS GENUS_PIVOT_NEIGHBOR_DOMAIN_COUNT_FINAL;

CREATE TABLE GENUS_PIVOT_NEIGHBOR_DOMAIN_COUNT_FINAL
  USING PARQUET
  AS
  SELECT
    A.GENUS_NAME,
    A.PIVOT_DOMAIN_ARCHITECTURE_UID_KEY,
    A.NEIGHBOR_DOMAIN_ARCHITECTURE_UID_KEY,
    CASE WHEN A.NEIGHBOR_TYPE = 'PD'
      THEN 'D'
      ELSE A.NEIGHBOR_TYPE
    END AS NEIGHBOR_TYPE,
    A.COUNT
    FROM
      GENUS_PIVOT_NEIGHBOR_DOMAIN_COUNT A
      INNER JOIN GENUS_MINIMUM_CUTOFF_THRESHOLD B ON
        B.GENUS_NAME = A.GENUS_NAME AND
        (A.NEIGHBOR_TYPE != 'PD' OR A.COUNT >= B.THRESHOLD)
      WHERE
        A.NEIGHBOR_DOMAIN_ARCHITECTURE_UID_KEY IS NOT NULL;

CACHE TABLE GENUS_PIVOT_NEIGHBOR_DOMAIN_COUNT_FINAL;

SELECT
  COUNT(1) AS NUM_ROWS,
  COUNT(DISTINCT GENUS_NAME) AS NUM_DISTINCT_GENERA,
  COUNT(DISTINCT PIVOT_DOMAIN_ARCHITECTURE_UID_KEY) AS NUM_DISTINCT_PIVOT_DAS,
  COUNT(DISTINCT NEIGHBOR_DOMAIN_ARCHITECTURE_UID_KEY) AS NUM_DISTINCT_NEIGHBOR_DAS
  FROM
    GENUS_PIVOT_NEIGHBOR_DOMAIN_COUNT_FINAL;

SELECT *
  FROM
    GENUS_PIVOT_NEIGHBOR_DOMAIN_COUNT_FINAL
    ORDER BY 1, 5 DESC
    LIMIT 20;
