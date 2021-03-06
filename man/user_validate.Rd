% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/user_validate.R
\name{user_validate}
\alias{user_validate}
\title{Validates users have been allocated correctly}
\usage{
user_validate(
  redcap_project_uri,
  redcap_project_token,
  use_ssl = TRUE,
  df_user_master = NULL,
  user_exclude = NULL
)
}
\arguments{
\item{redcap_project_uri}{URI (Uniform Resource Identifier) for the REDCap instance.}

\item{redcap_project_token}{API (Application Programming Interface) for the REDCap project.}

\item{use_ssl}{Logical value whether verify the peer's SSL certificate should be evaluated (default=TRUE)}

\item{df_user_master}{Optional dataframe containing at least 2 columns (username, data_access_group) used to evaluate incorrect DAG, and compare to users currently uploaded}

\item{user_exclude}{= Vector of any usernames to be excluded.}
}
\value{
Nested dataframe of (i) Users with NA access rights to forms (ii) Users with an unallocated DAG (iii). Users with an incorrect DAG according to df_user_master.  (iv). Users absent from the redcap project, but present in df_user_master.  (v). Users present on the redcap project, but absent in df_user_master.
}
\description{
Used to check all users have been appropriately (dag_unallocated) and correctly (dag_incorrect) allocated to a DAG, and that all user forms rights have been uploaded correctly. Note: if NA, this will default to view & edit access for all forms.
}
