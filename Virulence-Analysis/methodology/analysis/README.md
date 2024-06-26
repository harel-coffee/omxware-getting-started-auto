# Pipeline Documentation

[back to parent](../README.md)

The following documents the steps required for generating virulence profiles and vectors.

1. [Parse](/Virulence-Analysis/methodology/vfdb/README.md) VFDB proteins and genes.
2. [Stage](/Virulence-Analysis/methodology/analysis/staging/README.md) data into Apache Spark.
3. [Scrub](/Virulence-Analysis/methodology/analysis/scrubbing/README.md) the staged data.
4. [Create](/Virulence-Analysis/methodology/analysis/core/domain_architecture/README.md) domain architecture table.
5. [Create](/Virulence-Analysis/methodology/analysis/core/pivot_protein/README.md) pivot protein table.
6. [Create](/Virulence-Analysis/methodology/analysis/core/genome_pivot_protein/README.md) genome pivot protein table.
7. [Create](/Virulence-Analysis/methodology/analysis/core/genome_pivot_neighbor_protein/README.md) genome pivot neighbor protein table.
8. [Create](/Virulence-Analysis/methodology/analysis/core/genome_pivot_neighbor_protein_domain/README.md) genome pivot neighbor protein domain table.
9. [Create](/Virulence-Analysis/methodology/analysis/core/genome_pivot_neighbor_domain_count/README.md) genome pivot neighbor domain count table.
10. [Create](/Virulence-Analysis/methodology/analysis/core/genus_pivot_neighbor_domain_count/README.md) genus pivot neighbor domain count table.
11. [Compute](/Virulence-Analysis/methodology/analysis/core/genus_minimum_cutoff_threshold/README.md) by genus minimum cutoff threshold.
12. [Create](/Virulence-Analysis/methodology/analysis/core/genus_pivot_neighbor_domain_count_final/README.md) genus pivot neighbor domain count final table.
13. [Create](/Virulence-Analysis/methodology/analysis/core/genome_pivot_neighbor_domain_count_final/README.md) genome pivot neighbor domain count final table.
14. [Compute](/Virulence-Analysis/methodology/analysis/core/genus_pct_site_based/README.md) number of site based neighbors by genus.
15. [Compute](/Virulence-Analysis/methodology/analysis/core/overall_summary_stats/README.md) overall summary statistics
