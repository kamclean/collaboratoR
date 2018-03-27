# user_validate-------------------------
# Use: To check all users have been appropriately (dag_unallocated)and correctly (dag_incorrect) allocated to a DAG, and that all user forms rights have been uploaded correctly (if NA, this will default to view & edit access for all forms)
# users.df = Dataframe containing at least 2 columns (username, data_access_group)
# users_exception = Vector of usernames to be excluded from comparison (e.g. users who should have access to the whole dataset (dag = NA) or are associated with multiple DAGs in users.df)
user_validate <- function(redcap_project_uri, redcap_project_token, users.df, users_exception){
  require("dplyr")
  require("readr")
  require("RCurl")
  require("tidyr")
  require("tibble")
  "%ni%" <- Negate("%in%")

  postForm(
    uri=redcap_project_uri,
    token= redcap_project_token,
    content='user',
    format='csv') %>%
    read_csv() -> user_current

  user_current %>%
    select(username, data_access_group, forms) %>%
    filter(is.na(forms)==T) %>%
    tibble::as_tibble() -> forms_na

  user_current %>%
    select(username, data_access_group)  %>%
    filter(is.na(data_access_group)) %>%
    filter(username %ni% users_exception) -> dag_unallocated

  merge.data.frame(users.df, user_current, by = "username") %>%
    select("username" = username,
           "DAG_user_new" = data_access_group.x,
           "DAG_user_current" = data_access_group.y) %>%
    filter(username %ni% users_exception) %>%
    filter(DAG_user_new!=substr(DAG_user_current, 1, 18)) %>%
    tibble::as_tibble() -> dag_incorrect

  check.output <- list("forms_na" = forms_na,
                       "dag_unallocated" = dag_unallocated,
                       "dag_incorrect" = dag_incorrect)
  return(check.output)}