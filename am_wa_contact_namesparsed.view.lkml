#   include: "wa_fact_registration.view.lkml"
#   include: "*.view.lkml"
#   include: "/webassign/webassign.model.lkml"
 #  include: "instructor_analysi*.model.lkml"

view: am_wa_contact_namesparsed {
#  extends: [wa_fact_registration]
  sql_table_name: DEV.ZCM.AM_WA_CONTACT_NAMESPARSED ;;

 dimension: dist_instructor_name_id {
    type: string
    sql: ${TABLE}."DIST_INSTRUCTOR_NAME_ID" ;;
  }
  dimension: instructor_fname {
    type: string
    sql: ${TABLE}."INSTRUCTOR_FNAME" ;;
  }
  dimension: instructor_id {
    type: number
    sql: ${TABLE}."INSTRUCTOR_ID" ;;
  }
  dimension: instructor_lname {
    type: string
    sql: ${TABLE}."INSTRUCTOR_LNAME" ;;
  }
  dimension: instructor_middlename {
    type: string
    sql: ${TABLE}."INSTRUCTOR_MIDDLENAME" ;;
  }
  dimension: instructor_title {
    type: string
    sql: ${TABLE}."INSTRUCTOR_TITLE" ;;
  }
  dimension: original_instructor_name {
    type: string
    sql: ${TABLE}."ORIGINAL_INSTRUCTOR_NAME" ;;
  }
  dimension: school_id {
    type: number
    sql: ${TABLE}."SCHOOL_ID" ;;
  }
  dimension: section_id {
    type: number
    sql: ${TABLE}."SECTION_ID" ;;
  }
  measure: count {
    type: count
    drill_fields: [original_instructor_name, instructor_fname, instructor_middlename, instructor_lname]
  }
}
