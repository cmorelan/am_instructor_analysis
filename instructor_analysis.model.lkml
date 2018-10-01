#connection: "snowflake_webassign"

  include: "*.view.lkml"
# include: "/webassign/*.view.lkml"
# include: "/webassign/webassig*.model.lkml"
#  include: "instructor_analysis_base.model.lkml"  # need this to be able to pull from both DEV and WEBASSIGN
# #include: "wa_fact_registration.view.lkml"
# include: "am_wa_contact_namesparsed.view.lkml"
 include: "/webassign/webassign.model.lkml"   # need this to be able to pull from both DEV and WEBASSIGN
 include: "/webassign/webassign.dims.model.lkml"

# explore: fact_registration_ext {
#   extends: [wa_fact_registration]
#   from: wa_fact_registration
#   view_label: "TEST"

#   join: am_wa_contact_namesparsed {
#     sql_table_name: DEV.ZCM.AM_WA_CONTACT_NAMESPARSED ;;
#     type: left_outer
#     relationship: many_to_many
#     sql_on: ${fact_registration.instructor_id}=${am_wa_contact_namesparsed.instructor_id}  ;;
#   }
#}


# explore: wa_fact_registration {
#   label: "WebAssign Instructor"
#   from: wa_fact_registration
# #  extends: [fact_registration]
#   view_label: "ACTIVATIONS TEST"
# #  fields: [fact_registration*, -course_instructor_id, -section_instructor_id]
#
#
# join: am_wa_contact_namesparsed {
# #  sql_table_name: DEV.ZCM.am_wa_contact_namesparsed ;;
#   type: inner
#   relationship: many_to_many
#   sql_on: ${wa_fact_registration.instructor_id}=${am_wa_contact_namesparsed.instructor_id} ;;
# }

# join: wa_instructor_union {
#   type: inner
#   relationship: many_to_one
#   sql_on: (${dim_section.course_instructor_id}=${wa_instructor_union.instructor_id}
#     OR ${dim_section.section_instructor_id}=${wa_instructor_union.instructor_id});;
# }  # Need to union entire wa_fact_registration
#}
