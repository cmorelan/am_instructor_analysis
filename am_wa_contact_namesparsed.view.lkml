#   include: "wa_fact_registration.view.lkml"
#   include: "*.view.lkml"
#   include: "/webassign/webassign.model.lkml"
 #  include: "instructor_analysi*.model.lkml"

view: am_wa_contact_namesparsed {
  view_label: "Instructor"
#  extends: [wa_fact_registration]
  sql_table_name: DEV.ZCM.AM_WA_CONTACT_NAMESPARSED ;;

 dimension: dist_instructor_name_id {
  label: "    Instructor Name ID"
  description: "Unique identifier for instructor ids with more than one record for instructor name"
  group_label: " Instructor"
    type: string
    sql: ${TABLE}."DIST_INSTRUCTOR_NAME_ID" ;;
  }
  dimension: instructor_fname {
    label: "  Instructor First Name"
    group_label: " Instructor"
    type: string
    sql: ${TABLE}."INSTRUCTOR_FNAME" ;;
  }
  dimension: instructor_id {
    hidden: yes
    type: number
    sql: ${TABLE}."INSTRUCTOR_ID" ;;
  }
  dimension: instructor_lname {
    type: string
    group_label: " Instructor"
    label: " Instructor Last Nasme"
    sql: ${TABLE}."INSTRUCTOR_LNAME" ;;
  }
  dimension: instructor_middlename {
    type: string
    label: " Instructor Middle Name"
    group_label: " Instructor"
    sql: ${TABLE}."INSTRUCTOR_MIDDLENAME" ;;
  }
  dimension: instructor_title {
    type: string
    hidden: yes
    sql: ${TABLE}."INSTRUCTOR_TITLE" ;;
  }
  dimension: original_instructor_name {
    type: string
    hidden:  yes
    sql: ${TABLE}."ORIGINAL_INSTRUCTOR_NAME" ;;
  }
  dimension: school_id {
    type: number
    hidden: yes
    sql: ${TABLE}."SCHOOL_ID" ;;
  }
  dimension: section_id {
    type: number
    hidden: yes
    sql: ${TABLE}."SECTION_ID" ;;
  }
  measure: count {
    hidden:  yes
    type: count
    drill_fields: [original_instructor_name, instructor_fname, instructor_middlename, instructor_lname]
  }
}