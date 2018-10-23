Collaborator: REDCap summary data
=================================

Evaluating data uploaded to a REDCap project in the context of
multi-centre research projects is an important task for ensuring the
highest quality dataset for subsequent analyses, and for sharing
progress (whether internally or externally via social media). However,
summarising this data, particularly at a DAG-level, can be a challenging
and time-consuming task to produce on a regular basis.

The `redcap_sum()` function is designed to easily produce high quality
and informative summary data on a REDCap project (overall and at a
data\_access\_group level). This can be used for the purposes of sharing
progress (including identifying top performing DAGs), and identifying
individual DAGs which have not yet uploaded data or have not completed
data upload.

Requirements
------------

The `redcap_sum()` function is designed to be simple from the point of
use - the only requirements are a valid URI (Uniform Resource
Identifier) and API (Application Programming Interface) for the REDCap
project.

However, this is intended to have a high degree of customisability to
fit the needs of a variety of projects. For example, Being able to
easily: - Exclude individual records (`record_exclude`) or whole data
access groups (`dag_exclude`) from the record count (e.g. records or
DAGs that were found to be ineligible). - Exclude users (`user_exclude`)
from the total REDCap user count (e.g. administrator user accounts). -
Define variables that should contribute towards evaluation of data
completeness. This can be achieved by either excluding (`var_exclude`),
or specifying certain variables (`var_complete`). - Generation of
summary data by DAG unless `centre_sum` is specified as FALSE (default
`centre_sum=T`)

Limitations: - This function has not yet been tested on REDCap projects
with multiple events.

Main Features
-------------

### (1) Basic Function

At it’s most basic, `redcap_sum()` can produce an overall summary of
current data on the REDCap project: - `n_record_all` is the number of
all records currently on the REDCap project (minus any records removed
using `record_exclude` or in DAGs removed using `dag_exclude`).

-   `n_record_com` is the number of all complete records currently on
    the REDCap project (minus any records removed using `record_exclude`
    or in DAGs removed using `dag_exclude`), with no missing data across
    the record (unless certain data fields are either excluded
    (`var_exclude`) or specified (`var_complete`)).

-   `prop_com` /`pct_com` is the respective proportion and percentage of
    complete records in the project.

-   `n_dag` is the number of data access groups (DAGs) for all records
    currently on the REDCap project (minus any records removed using
    `record_exclude` or in DAGs removed using `dag_exclude`).

-   `n_users` is the number of users on the REDCap project (minus any
    users in DAGs removed using `dag_exclude`). Note all users not
    assigned to a DAG will automatically be excluded.

-   `last_update` is the date which the summary data was generated on.

<!-- -->

    redcap_sum(redcap_project_uri, redcap_project_token, centre_sum = F) 

    ##   n_record_all n_record_com prop_com pct_com n_dag n_users last_update
    ## 1           50           26     0.52   52.0%     8      30 23-Oct-2018

### (2) Centre summary data

However, more granular summary data on each DAG can also be obtained
using the same function. This centre summary data will automatically be
included within the output from `redcap_sum()` unless `centre_sum` is
specified as FALSE.

#### 1. `$dag_all` Output

This will produce a dataframe of the same summary data as outlined above
**grouped by each DAG instead** (minus any DAGs removed using
`dag_exclude`).

    redcap_sum(redcap_project_uri, redcap_project_token, centre_sum = T)$dag_all

    ## # A tibble: 10 x 7
    ##    dag        record_all record_com prop_com pct_com user_all last_update
    ##    <chr>           <dbl>      <dbl>    <dbl> <chr>      <int> <chr>      
    ##  1 hospital_a         10          5    0.5   50.0%          3 23-Oct-2018
    ##  2 hospital_e          9          6    0.667 66.7%          3 23-Oct-2018
    ##  3 hospital_g          7          4    0.571 57.1%          3 23-Oct-2018
    ##  4 hospital_b          6          3    0.5   50.0%          3 23-Oct-2018
    ##  5 hospital_f          6          3    0.5   50.0%          3 23-Oct-2018
    ##  6 hospital_h          6          2    0.333 33.3%          3 23-Oct-2018
    ##  7 hospital_d          4          1    0.25  25.0%          3 23-Oct-2018
    ##  8 hospital_c          2          2    1     100.0%         2 23-Oct-2018
    ##  9 hospital_i          0         NA   NA     <NA>           3 23-Oct-2018
    ## 10 hospital_j          0         NA   NA     <NA>           4 23-Oct-2018

#### 2. `$dag_nodata` Output

This will produce a dataframe of all DAG with users assigned on the
REDCap project, but no data uploaded to REDCap. This may be useful for
the purposes of targeting encouragement to upload data, or establishing
authorship on any research output.

    redcap_sum(redcap_project_uri, redcap_project_token, centre_sum = T)$dag_nodata

    ## # A tibble: 2 x 7
    ##   dag        record_all record_com prop_com pct_com user_all last_update
    ##   <chr>           <dbl>      <dbl>    <dbl> <chr>      <int> <chr>      
    ## 1 hospital_i          0         NA       NA <NA>           3 23-Oct-2018
    ## 2 hospital_j          0         NA       NA <NA>           4 23-Oct-2018

#### 3. `$dag_incom` Output

This will produce a dataframe of all DAG with incomplete records (the
definition of completeness customisable as discussed above). This may be
useful for the purposes of follow up regarding (essential) missing data
at each of these DAGs.

    redcap_sum(redcap_project_uri, redcap_project_token, centre_sum = T)$dag_incom

    ## # A tibble: 7 x 7
    ##   dag        record_all record_com prop_com pct_com user_all last_update
    ##   <chr>           <dbl>      <dbl>    <dbl> <chr>      <int> <chr>      
    ## 1 hospital_a         10          5    0.5   50.0%          3 23-Oct-2018
    ## 2 hospital_e          9          6    0.667 66.7%          3 23-Oct-2018
    ## 3 hospital_g          7          4    0.571 57.1%          3 23-Oct-2018
    ## 4 hospital_b          6          3    0.5   50.0%          3 23-Oct-2018
    ## 5 hospital_f          6          3    0.5   50.0%          3 23-Oct-2018
    ## 6 hospital_h          6          2    0.333 33.3%          3 23-Oct-2018
    ## 7 hospital_d          4          1    0.25  25.0%          3 23-Oct-2018

#### 4. `$dag_top_n` Output

This will produce a dataframe of the DAGs with the most records uploaded
overall (the number of DAGs listed is defined by `n_top_dag` with top 10
DAG being default). This may be useful for the purposes of publicity
surrounding the project.

    redcap_sum(redcap_project_uri, redcap_project_token, centre_sum = T, n_top_dag = 5)$dag_top_n

    ## # A tibble: 5 x 2
    ##   top_n_dag  record_all
    ##   <chr>           <dbl>
    ## 1 hospital_a         10
    ## 2 hospital_e          9
    ## 3 hospital_g          7
    ## 4 hospital_b          6
    ## 5 hospital_f          6