collaborator
==========

The `collaborator` package provides functions which help facilitate administration of multi-centre research using the [REDCap](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2700030/) (Research Electronic Data Capture) application. These functions have been developed and utilised within several collaborative research projects from [Student Audit and Research in Surgery (STARSurg)](https://www.starsurg.org), [EuroSurg](http://www.eurosurg.org), and [West Midlands Research Collaborative (WMRC)](http://www.wmresearch.org.uk).

All functions have been developed with the aim of being applicable to a broad range of REDCap projects. Any suggestions for further functions are welcome, however these would need to be aligned with this aim.

Installation and Documentation
------------------------------

You can install `collaborator` from github with:

``` r
# install.packages("devtools")
devtools::install_github("kamclean/collaborator")
```

It is recommended that this package is used together with `tidyverse` packages.

Vignettes
---------

[Redcap User Management: 1. Explore Current Users](https://github.com/kamclean/collaborator/blob/master/vignettes/vignette_user_1_explore.Rmd)

[Redcap User Management: 2. Automatically Assign User Rights](https://github.com/kamclean/collaborator/blob/master/vignettes/vignette_user_2_assign.Rmd)

[Generating Authorship Lists](https://github.com/kamclean/collaborator/blob/master/vignettes/vignette_authors.Rmd)

[Generating Missing Data Reports](https://github.com/kamclean/collaborator/blob/master/vignettes/vignette_missing.Rmd)

[Generating a Simple, Easily-Shareable Data Dictionary](https://github.com/kamclean/collaborator/blob/master/vignettes/vignette_data_dict.Rmd)
