######### NEED TO UNION FACT_REGISTRATION TABLE AND USE THAT A BASE EXPLORE

#connection: "snowflake_dev"

include: "instructor_analysis.model.lkml"  # need this to be able to pull from both DEV and WEBASSIGN
 include: "/webassign/webassig*.model.lkml"   # need this to be able to pull from both DEV and WEBASSIGN
# include: "/webassign/*.view.lkml"
# include: "wa_fact_registration.view.lkml"
include: "*.view.lkml"
# include: "wa_fact_registration.view.lkml"




####################################### PAY ATTENTION  ########################################
################ NEED TO UNION THE FACT_REGISTRATION TABLE AND USE IT #########################
################                AS BASE VIEW FOR EXPLORE              #########################
###############################################################################################
# explore: fact_registration_base {
#   extends: [fact_registration]
#
#   join: wa_fact_registration {
#     sql_on:  ;;
#   }
# }
#
#  explore: wa_fact_registration {
#      extends: [fact_registration]
#     from: wa_fact_registration
#     view_label: "ACTIVATIONS EXTENDED"
#     label: "ACTIVATIONS EXTENDED"
#   sql_always_where:
#   (
#     (
#       UPPER(${dim_section.section_instructor_email} ) NOT LIKE UPPER( '%cengage%' )    --- scratch table
#       AND UPPER( ${dim_section.section_instructor_email} ) NOT LIKE UPPER( '%webassign%' )
#       AND UPPER( ${dim_section.section_instructor_email} ) NOT LIKE UPPER( '%openstax%' )
#       OR ${dim_section.section_instructor_email} IS NULL
#     )
#   )
#   AND(
#     (
#       UPPER( ${dim_section.course_instructor_email} ) NOT LIKE UPPER( '%cengage%' )  -- -scratch table
#       AND UPPER(  ${dim_section.course_instructor_email} ) NOT LIKE UPPER( '%webassign%' )
#       AND UPPER(  ${dim_section.course_instructor_email} ) NOT LIKE UPPER( '%openstax%' )
#       OR  ${dim_section.course_instructor_email} IS NULL
#     )
#   )
#   AND(
#     (
#       UPPER( ${dim_school.country_name} )= UPPER( 'United States' )
#       OR UPPER( ${dim_school.country_name} )= UPPER( 'Canada' )
#     )
#   )
#   AND(
#     (
#       UPPER( ${dim_school.type} )= UPPER( 'Community College' )
#       OR UPPER( ${dim_school.type} )= UPPER( 'University' )
#     )
#   )
#   AND(
#     (
#       UPPER( ${dim_discipline.discipline_name} )= UPPER( 'Mathematics' )
#     )
#   )
#   AND(
#     (
#          UPPER( ${dim_time.timeschoolsemesterdesc} )= UPPER( 'Fall15' )
#       OR UPPER( ${dim_time.timeschoolsemesterdesc} )= UPPER( 'Fall16' )
#       OR UPPER( ${dim_time.timeschoolsemesterdesc} )= UPPER( 'Fall17' )
#       OR UPPER( ${dim_time.timeschoolsemesterdesc} )= UPPER( 'Fall18' )
#       OR UPPER( ${dim_time.timeschoolsemesterdesc} )= UPPER( 'Spring15' )
#       OR UPPER( ${dim_time.timeschoolsemesterdesc} )= UPPER( 'Spring16' )
#       OR UPPER( ${dim_time.timeschoolsemesterdesc} )= UPPER( 'Spring17' )
#       OR UPPER( ${dim_time.timeschoolsemesterdesc} )= UPPER( 'Spring18' )
#       OR UPPER( ${dim_time.timeschoolsemesterdesc} )= UPPER( 'Summer15' )
#       OR UPPER( ${dim_time.timeschoolsemesterdesc} )= UPPER( 'Summer16' )
#       OR UPPER( ${dim_time.timeschoolsemesterdesc} )= UPPER( 'Summer17' )
#       OR UPPER( ${dim_time.timeschoolsemesterdesc} )= UPPER( 'Summer18' )
#     )
#   );;
#   join: am_wa_contact_namesparsed {
#     type: left_outer
#     relationship: many_to_many
#     sql_on: ${wa_fact_registration.instructor_id}=${am_wa_contact_namesparsed.instructor_id}  ;;
#   }
#}
