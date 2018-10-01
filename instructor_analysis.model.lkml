

  include: "*.view.lkml"
  include: "instructor_analysis_base.model.lkml"  # need this to be able to pull from both DEV and WEBASSIGN
  include: "/webassign/webassig*.model.lkml"   # need this to be able to pull from both DEV and WEBASSIGN
#  include: "/webassign/responses.view.lkml"
#  include: "/webassign/dim_section.view.lkml"


explore: wa_fact_registration {}

explore: wa_fact_registration_extended {
  extends: [fact_registration]    ### Extending fact_registration model from webassign project (from snowflake DATABASE.SCHEMA: WEBASSIGN.FR_OLAP_REGISTRATION_REPORTS)
  from: wa_fact_registration    ### Using Unioned fact_registration derived table defined in wa_fact_registration.view.lkml file
 fields: [fact_registration*, dim_section*, dim_product_family*, dim_discipline*, dim_time*, dim_faculty*, dim_school*, dim_textbook*
    , am_wa_contact_namesparsed*, -fact_registration.course_instructor_id, -fact_registration.section_instructor_id]    ################ Including all fields from wa_fact_registration & other tables in model -course and section instructor ID fields

  join: am_wa_contact_namesparsed {
    sql_table_name: DEV.ZCM.AM_WA_CONTACT_NAMESPARSED ;;
    type: left_outer
    relationship: many_to_many
    sql_on: ${fact_registration.instructor_id}=${am_wa_contact_namesparsed.instructor_id}  ;;
  }
}
