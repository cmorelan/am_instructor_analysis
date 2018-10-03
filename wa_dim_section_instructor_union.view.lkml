include: "/webassign/webassig*.model.lkml"
include: "instructor_analysis.model.lkml"

view: wa_dim_section_instructor_union {
  view_label: "Instructor"
  derived_table: {
    sql:
    WITH sd AS (
SELECT
    DISTINCT dim_section_id
    , course_instructor_id
    , course_instructor_email
    , course_instructor_name
    , section_instructor_id
    , section_instructor_email
    , section_instructor_name
    , CASE WHEN course_instructor_id=section_instructor_id THEN 'Same' ELSE 'Different' END AS same_diff
FROM WEBASSIGN.FT_OLAP_REGISTRATION_REPORTS.DIM_SECTION
)
, udsiu AS (
     SELECT
        DISTINCT dim_section_id
        , course_instructor_id AS instructor_id
        , course_instructor_email as instructor_email
        , course_instructor_name as instructor_name
        , 'Course Instructor' AS instructor_lvl
     FROM sd
     WHERE same_diff='Different'
UNION
  SELECT
      DISTINCT dim_section_id
      , section_instructor_id AS instructor_id
      , section_instructor_email as instructor_email
      , section_instructor_name as instructor_name
      , 'Section Instructor' AS instructor_lvl
  FROM sd
  WHERE same_diff = 'Different'
UNION
  SELECT
      DISTINCT dim_section_id
      , section_instructor_id AS instructor_id
      , section_instructor_email as instructor_email
      , section_instructor_name as instructor_name
      , 'Course & Section Instructor' AS instructor_lvl
  FROM sd
  WHERE same_diff='Same'
)
select * from udsiu;;
  }

  dimension: dim_section_id { primary_key: yes sql: ${TABLE}.dim_section_id;; hidden: yes group_label: " Instructor"}
  dimension: instructor_id { sql: ${TABLE}.instructor_id;;label:"     Instructor ID"   group_label: " Instructor" hidden: no}

  dimension: instructor_lvl {
    label: "Instructor Type"
    description: "is the Course Instructor, Section Instructor, or Both Course & Section Instructor from dim_section_id"
    sql: ${TABLE}.instructor_lvl;;
    group_label: " Instructor"}

  dimension: instructor_email { sql: ${TABLE}.instructor_email;;  group_label: " Instructor"}
  dimension: instructor_name {label:"   Instructor Full Name" sql: ${TABLE}.instructor_name  ;;  group_label: " Instructor"}

}
