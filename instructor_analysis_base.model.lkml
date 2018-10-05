#X# One of the following includes is likely needed in this file:
# include: "zam_wa_contact_namesparsed.view.lkml"
# include: "zwa_dim_section_instructor_union.view.lkml"
######### NEED TO UNION FACT_REGISTRATION TABLE AND USE THAT A BASE EXPLORE

connection: "snowflake_dev" # Need to declare a connection to DEV database here

include: "am_opty_raw.view.lkml"  # Include only the views from DEV database

explore: am_opty_raw {    # Need an explore for each view from the DEV database to be used in instructor_analysis model
  from: am_opty_raw
  sql_table_name: DEV.ZCM.AM_OPTY_RAW ;;
}
