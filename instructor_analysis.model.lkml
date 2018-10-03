

  include: "*.view.lkml"
  include: "instructor_analysis_base.model.lkml"  # need this to be able to pull from both DEV and WEBASSIGN
  include: "/webassign/webassig*.model.lkml"   # need this to be able to pull from both DEV and WEBASSIGN



explore: wa_dim_section {}
explore: wa_dim_section_instructor_union {}
explore: wa_fact_registration {}
explore: wa_dim_school {}




explore: wa_fact_registration_extended {
  extends: [fact_registration]    ### Extending fact_registration model from webassign project (from snowflake DATABASE.SCHEMA: WEBASSIGN.FR_OLAP_REGISTRATION_REPORTS)
  from: wa_fact_registration    ### Using Unioned fact_registration derived table defined in wa_fact_registration.view.lkml file

# Including all tables in fact_activation model except dim_faculty due to an error and the fact that I never use it
# Including all fields from wa_fact_registration & other tables in model except -course and section instructor ID fields from fact_activation
# MAKE SURE TO INCLUDE ANY ADDED TABLES IN THE FIELDS SECTION BELOW

  fields: [
             wa_dim_section*
           , wa_dim_section_instructor_union*
           , fact_registration*
           ,  dim_product_family*
           , dim_discipline*
           , dim_time*
           , wa_dim_school*
           , wa_dim_textbook*
           , am_wa_contact_namesparsed*
               , wa_textbook_grtopic.grouped_topic
               , -fact_registration.course_instructor_id
               , -fact_registration.section_instructor_id
          ]

  join: wa_dim_section {
    from: wa_dim_section
    type: left_outer
    relationship: many_to_one
    sql_on:
              ${fact_registration.dim_section_id}||${fact_registration.instructor_id}
          =   ${wa_dim_section.dim_section_id}||${wa_dim_section.course_instructor_id} ;;
  }

  join: wa_dim_section_instructor_union {  ########### There is a bad join either here or form wa_dim_section causing fact_registration_id to duplicate in the explore since there is not section_id need to investigate: https://cengage.looker.com/explore/instructor_analysis/wa_fact_registration_extended?qid=uOnhATZT5GK7wEu7sW1bw0&toggle=fil
    type: left_outer
    relationship: many_to_one
    sql_on:
              ${fact_registration.dim_section_id}||${fact_registration.instructor_id}
          =   ${wa_dim_section_instructor_union.dim_section_id}||${wa_dim_section_instructor_union.instructor_id}
          ;;
  }

  join: am_wa_contact_namesparsed {
    sql_table_name: DEV.ZCM.AM_WA_CONTACT_NAMESPARSED ;;
    type: left_outer
    relationship: many_to_many
    sql_on: ${fact_registration.instructor_id}=${am_wa_contact_namesparsed.instructor_id}  ;;
  }
  join: wa_dim_school {
    sql_on: ${fact_registration.dim_school_id} = ${wa_dim_school.dim_school_id} ;;
    relationship: many_to_one
  }

 join: wa_dim_textbook {
   from: wa_dim_textbook
  type: left_outer
  sql_on: ${fact_registration.dim_textbook_id} = ${wa_dim_textbook.dim_textbook_id} ;;
  relationship: many_to_one
 }

  join: wa_textbook_grtopic {
    type: left_outer
    relationship: one_to_one
    sql_on:
          ${wa_dim_textbook.code}=${wa_textbook_grtopic.wa_prod_code};;
  }

}
