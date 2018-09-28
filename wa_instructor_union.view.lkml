#############################################################################################################################################################################################################
#############################################################################################################################################################################################################
##########                                                                                                                                                                                         ##########
########## Contains 3 views. course_instructor and section_instructor are NDT's connecting to the wa_fact_registration explore (cannot do this with a SQL defined derived table). instructor_union ##########
########## is a SQL defined table that unions together the other two (union cannot be done with NDTs). This approach requires all three tables this way in order to maintain the sql_always_when   ##########
########## filters defined in the explore, keeping that logic in one place. Another option would be to include 1 SQL defined view here with the filter logic, but it would require updates to the  ##########
##########                                                                         logic to be made in multiple locations.                                                                         ##########
##########                                                                                                                                                                                         ##########
#############################################################################################################################################################################################################
#############################################################################################################################################################################################################




#include: "instructor_analysis_base.model.lkml"
include: "/webassign/dim_section.view.lkml"
include: "wa_fact_registration.view.lkml"
#include: "instructor_union.view.lkml"

view: wa_instructor_union {
  #extends: [course_instructor, section_instructor]
  derived_table: {
    sql:
    with u as(
         SELECT
                DISTINCT s.section_instructor_id AS instructor_id
              , s.cl_entity_number as entity_number
              , s.section_instructor_name as instructor_name
              , s.section_instructor_email as instructor_email
          FROM ${section_instructor.SQL_TABLE_NAME} as s
--            FROM ${dim_section.SQL_TABLE_NAME}
        UNION
         SELECT
                DISTINCT c.course_instructor_id AS instructor_id
              , c.cl_entity_number as entity_number
              , c.course_instructor_name as instructor_name
              , c.course_instructor_email as instructor_email
          FROM ${course_instructor.SQL_TABLE_NAME} as c
--            FROM ${dim_section.SQL_TABLE_NAME}
     )
    , c as (
        SELECT
            DISTINCT u.instructor_id
            , count(DISTINCT u.entity_number) as entity_count
            , count(DISTINCT u.instructor_name) as name_count
            , count(DISTINCT u.instructor_email) as email_count
        FROM u
        GROUP BY 1
        HAVING ( name_count = 1 AND email_count =1)
     )
       SELECT
            DISTINCT u.instructor_id
            , u.entity_number as entity_number
            , u.instructor_name as instructor_name
            , u.instructor_email as instructor_email
            , c.entity_count as entity_count
            , c.name_count as name_count
            , c.email_count as email_count
        FROM u
        INNER JOIN c on u.instructor_id=c.instructor_id
      ;;
  }

  dimension: entity_number {
    label: "Cl Entity Number"
  }
  dimension: instructor_id {
    label: "   Instructor ID"
    type: number
   }
  dimension: instructor_name {
    label: "  Instructor Name"
  }
  dimension: instructor_email {
    label: " Instructor Email"
  }


  dimension: entity_count {
    description: "Using to validate and test. Hide once done"
  }
  dimension: name_count {
    description: "Using to validate and test. Hide once done"
  }
  dimension: email_count {
    description: "Using to validate and test. Hide once done"
  }

  measure: countall {
    type: number
    sql: count(*) ;;
  }
  measure: count_instructor_ids {
    type: count_distinct
    sql: ${instructor_id} ;;
  }
  measure: count_entity {
    type: count_distinct
    sql: ${TABLE}.entity_number ;;
  }
  measure: count_names {
    type: count_distinct
    sql: ${TABLE}.instructor_name ;;
  }
  measure: count_email {
    type: count_distinct
    sql: ${TABLE}.instructor_email ;;
  }
}





include: "instructor_analysis_base.model.lkml"

view: course_instructor {
    derived_table: {
       explore_source: wa_fact_registration {

        column: cl_entity_number { field: dim_school.cl_entity_number }
        column: course_instructor_id { field: dim_section.course_instructor_id }
        column: course_instructor_name { field: dim_section.course_instructor_name }
        column: course_instructor_email { field: dim_section.course_instructor_email }
      }
    }


    dimension: cl_entity_number {
      label: "School Cl Entity Number"
    }
    dimension: course_instructor_id {
      label: "Course Instructor ID"
      type: number
    }
    dimension: course_instructor_name {
      label: "Course Instructor Name"
    }
    dimension: course_instructor_email {
      label: "Course Instructor Email"
    }
    measure: countall {
      type: number
      sql: count(*) ;;
    }
    measure: count_instructor_ids {
      type: count_distinct
      sql: ${course_instructor_id} ;;
    }
}

# If necessary, uncomment the line below to include explore_source.

include: "instructor_analysis_base.model.lkml"

view: section_instructor {
    derived_table: {
    explore_source: wa_fact_registration {
      column: cl_entity_number { field: dim_school.cl_entity_number }
      column: section_instructor_id { field: dim_section.section_instructor_id }
      column: section_instructor_name { field: dim_section.section_instructor_name }
      column: section_instructor_email { field: dim_section.section_instructor_email }
    }
  }
  dimension: cl_entity_number {
    label: "School Cl Entity Number"
  }
  dimension: section_instructor_id {
    label: "Section Instructor ID"
    type: number
  }
  dimension: section_instructor_name {
    label: "Section Instructor Name"
  }
  dimension: section_instructor_email {
    label: "Section Instructor Email"
  }
  measure: countall {
    type: number
    sql: count(*) ;;
  }
  measure: count_instructor_ids {
    type: count_distinct
    sql: ${section_instructor_id} ;;
  }
}
