######### NEED TO UNION FACT_REGISTRATION TABLE AND USE THAT A BASE EXPLORE

connection: "snowflake_dev" # Need to declare a connection to DEV database here

include: "am_wa_contact_namesparsed.view.lkml"  # Include only the views from DEV database

explore: am_wa_contact_namesparsed {    # Need an explore for each view from the DEV database to be used in instructor_analysis model
  from: am_wa_contact_namesparsed
  sql_table_name: DEV.ZCM.AM_WA_CONTACT_NAMESPARSED ;;
}
