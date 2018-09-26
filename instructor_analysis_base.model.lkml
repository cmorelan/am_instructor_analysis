#connection: "snowflake_webassign"

include: "/webassign/webassign.model.lkml"
include: "/webassign/*.view.lkml"



explore: wa_fact_registration {
  extends: [fact_registration]
  sql_always_where:
  (
    (
      UPPER(${dim_section.section_instructor_email} ) NOT LIKE UPPER( '%cengage%' )    --- scratch table
      AND UPPER( ${dim_section.section_instructor_email} ) NOT LIKE UPPER( '%webassign%' )
      AND UPPER( ${dim_section.section_instructor_email} ) NOT LIKE UPPER( '%openstax%' )
      OR ${dim_section.section_instructor_email} IS NULL
    )
  )
  AND(
    (
      UPPER( ${dim_section.course_instructor_email} ) NOT LIKE UPPER( '%cengage%' )  -- -scratch table
      AND UPPER(  ${dim_section.course_instructor_email} ) NOT LIKE UPPER( '%webassign%' )
      AND UPPER(  ${dim_section.course_instructor_email} ) NOT LIKE UPPER( '%openstax%' )
      OR  ${dim_section.course_instructor_email} IS NULL
    )
  )
  AND(
    (
      UPPER( ${dim_school.country_name} )= UPPER( 'United States' )
      OR UPPER( ${dim_school.country_name} )= UPPER( 'Canada' )
    )
  )
  AND(
    (
      UPPER( ${dim_school.type} )= UPPER( 'Community College' )
      OR UPPER( ${dim_school.type} )= UPPER( 'University' )
    )
  )
  AND(
    (
      UPPER( ${dim_discipline.discipline_name} )= UPPER( 'Mathematics' )
    )
  )
  AND(
    (
      UPPER( ${dim_time.timeschoolsemesterdesc} )= UPPER( 'Fall15' )
      OR UPPER( ${dim_time.timeschoolsemesterdesc} )= UPPER( 'Fall16' )
      OR UPPER( ${dim_time.timeschoolsemesterdesc} )= UPPER( 'Fall17' )
      OR UPPER( ${dim_time.timeschoolsemesterdesc} )= UPPER( 'Fall18' )
      OR UPPER( ${dim_time.timeschoolsemesterdesc} )= UPPER( 'Spring15' )
      OR UPPER( ${dim_time.timeschoolsemesterdesc} )= UPPER( 'Spring16' )
      OR UPPER( ${dim_time.timeschoolsemesterdesc} )= UPPER( 'Spring17' )
      OR UPPER( ${dim_time.timeschoolsemesterdesc} )= UPPER( 'Spring18' )
      OR UPPER( ${dim_time.timeschoolsemesterdesc} )= UPPER( 'Summer15' )
      OR UPPER( ${dim_time.timeschoolsemesterdesc} )= UPPER( 'Summer16' )
      OR UPPER( ${dim_time.timeschoolsemesterdesc} )= UPPER( 'Summer17' )
      OR UPPER( ${dim_time.timeschoolsemesterdesc} )= UPPER( 'Summer18' )
    )
  );;

#   join: wa_dim_section {
#     from: dim_section
#     sql_on: ${fact_registration.dim_section_id}=${dim_section.dim_section_id} ;;
#     relationship: many_to_one
#   }
}
