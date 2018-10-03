  include: "/webassign/fact_registration.view.lkml"
  include: "/webassign/webassig*.model.lkml"

######################################################################################################################################################################################################################
###############  TO MAKE THIS WORK, I HAD TO:
###############        1. INCLUDE THE VIEW BEING EXTENDED
###############        2. EXTEND THE VIEW BELOW
###############        3. USE THE DATABASE TABLES RATHER THAN VIEWS IN THE QUERY. EXCLUDING PDT'S IN LOOKER SINCE THIS IS REPLACING THE BASE VIEW FOR THE MODEL AND MODEL LOGIC WILL FOLLOW
###############        4. SOME OBJECTS WERE CASE SENSITIVE FOR SOME REASON, HAD TO MAKE SURE THEY WERE IN THE RIGHT CASE (ESP ALIASES)
###############        5. EXCLUDE FIELDS IN MODEL THAT WERE NOT DEFINED IN THE FINAL TABLE RESULTING FROM THIS QUERY
######################################################################################################################################################################################################################

view: wa_fact_registration {
  extends: [fact_registration]  #cant add dim tables here because query errors on multi primary keys (including the pk in each view included
  derived_table: {
    sql:
WITH u AS (--
  SELECT
        f.FACT_REGISTRATION_ID as fact_registration_id
      , f.DIM_TIME_ID as dim_time_id
      , f.NET_SALES_REVENUE as net_sales_revenue
      , f.DIM_PAYMENT_METHOD_ID as dim_payment_method_id
      , f.UPGRADES as upgrades
      , f.dim_section_id as dim_section_id
      , f.SSO_GUID as sso_guid
      , f.REDEMPTION_MODEL as redemption_model
      , f.EVENT_TYPE as event_type
      , f.TOKEN_ID as token_id
      , f.SCHOOL_ID as school_id
      , f.SECTION_ID as section_id
      , f.DIM_TEXTBOOK_ID as dim_textbook_id
      , f.PURCHASE_TYPE as purchase_type
      , f.COURSE_ID as course_id
      , f.GROSS_SALES_REVENUE as gross_sales_revenue
      , f.REGISTRATIONS as registrations
      , f.COUNT AS count
      , f.COURSE_INSTRUCTOR_ID AS instructor_id
      , f.DIM_SCHOOL_ID as dim_school_id
      , f.USER_ID as user_id
      , f.DIM_AXSCODE_ID as dim_axscode_id
      , f.USERNAME as username
    FROM WEBASSIGN.FT_OLAP_REGISTRATION_REPORTS.FACT_REGISTRATION AS f
    LEFT JOIN WEBASSIGN.FT_OLAP_REGISTRATION_REPORTS.DIM_SECTION AS dim_section ON f.dim_section_id = dim_section.dim_section_id
    LEFT JOIN WEBASSIGN.FT_OLAP_REGISTRATION_REPORTS.DIM_SCHOOL  AS dim_school ON f.dim_school_id = dim_school.DIM_SCHOOL_ID
    LEFT JOIN WEBASSIGN.FT_OLAP_REGISTRATION_REPORTS.DIM_TEXTBOOK  AS dim_textbook ON f.dim_textbook_id = dim_textbook.DIM_TEXTBOOK_ID
    LEFT JOIN WEBASSIGN.FT_OLAP_REGISTRATION_REPORTS.DIM_DISCIPLINE  AS dim_discipline ON dim_textbook.dim_discipline_id = dim_discipline.DIM_DISCIPLINE_ID
    INNER JOIN WEBASSIGN.FT_OLAP_REGISTRATION_REPORTS.DIM_TIME  AS dim_time ON f.dim_time_id = dim_time.DIM_TIME_ID
    WHERE
          ((UPPER( dim_section.COURSE_INSTRUCTOR_EMAIL ) NOT LIKE UPPER( '%cengage%' ) AND UPPER(  dim_section.COURSE_INSTRUCTOR_EMAIL ) NOT LIKE UPPER( '%webassign%' )
          AND UPPER(  dim_section.COURSE_INSTRUCTOR_EMAIL ) NOT LIKE UPPER( '%openstax%' ) OR  dim_section.COURSE_INSTRUCTOR_EMAIL IS NULL
          ))
      AND((
          UPPER( dim_school.COUNTRY_NAME )= UPPER( 'United States' ) OR UPPER( dim_school.COUNTRY_NAME )= UPPER( 'Canada' )
          ))
      AND((
          UPPER( dim_school.TYPE )= UPPER( 'Community College' )  OR UPPER( dim_school.TYPE )= UPPER( 'University' )
          ))
      AND((
          UPPER( dim_discipline.DISCIPLINE_NAME )= UPPER( 'Mathematics' )
          ))
      AND((UPPER( dim_time.TIMESCHOOLSEMESTERDESC )= UPPER( 'Fall15' )  OR UPPER( dim_time.TIMESCHOOLSEMESTERDESC )= UPPER( 'Fall16' ) OR UPPER( dim_time.TIMESCHOOLSEMESTERDESC )= UPPER( 'Fall17' ) OR UPPER( dim_time.TIMESCHOOLSEMESTERDESC )= UPPER( 'Fall18' )
          OR UPPER( dim_time.TIMESCHOOLSEMESTERDESC )= UPPER( 'Spring15' )  OR UPPER( dim_time.TIMESCHOOLSEMESTERDESC )= UPPER( 'Spring16' )  OR UPPER( dim_time.TIMESCHOOLSEMESTERDESC )= UPPER( 'Spring17' )  OR UPPER( dim_time.TIMESCHOOLSEMESTERDESC )= UPPER( 'Spring18' )
          OR UPPER( dim_time.TIMESCHOOLSEMESTERDESC )= UPPER( 'Summer15' )  OR UPPER( dim_time.TIMESCHOOLSEMESTERDESC )= UPPER( 'Summer16' )  OR UPPER( dim_time.TIMESCHOOLSEMESTERDESC )= UPPER( 'Summer17' ) OR UPPER( dim_time.TIMESCHOOLSEMESTERDESC )= UPPER( 'Summer18' )
          ))
--       AND((dim_textbook.DIM_TEXTBOOK_ID != '2220' AND dim_textbook.DIM_TEXTBOOK_ID is not null
--           ))
UNION
  SELECT
        f.FACT_REGISTRATION_ID as fact_registration_id
      , f.DIM_TIME_ID as dim_time_id
      , f.NET_SALES_REVENUE as net_sales_revenue
      , f.DIM_PAYMENT_METHOD_ID as dim_payment_method_id
      , f.UPGRADES as upgrades
      , f.dim_section_id as dim_section_id
      , f.SSO_GUID as sso_guid
      , f.REDEMPTION_MODEL as redemption_model
      , f.EVENT_TYPE as event_type
      , f.TOKEN_ID as token_id
      , f.SCHOOL_ID as school_id
      , f.SECTION_ID as section_id
      , f.DIM_TEXTBOOK_ID as dim_textbook_id
      , f.PURCHASE_TYPE as purchase_type
      , f.COURSE_ID as course_id
      , f.GROSS_SALES_REVENUE as gross_sales_revenue
      , f.REGISTRATIONS as registrations
      , f.COUNT AS count
      , f.SECTION_INSTRUCTOR_ID AS instructor_id
      , f.DIM_SCHOOL_ID as dim_school_id
      , f.USER_ID as user_id
      , f.DIM_AXSCODE_ID as dim_axscode_id
      , f.USERNAME as username
    FROM WEBASSIGN.FT_OLAP_REGISTRATION_REPORTS.FACT_REGISTRATION AS f
    LEFT JOIN WEBASSIGN.FT_OLAP_REGISTRATION_REPORTS.DIM_SECTION AS dim_section ON f.dim_section_id = dim_section.dim_section_id
    LEFT JOIN WEBASSIGN.FT_OLAP_REGISTRATION_REPORTS.DIM_SCHOOL  AS dim_school ON f.dim_school_id = dim_school.DIM_SCHOOL_ID
    LEFT JOIN WEBASSIGN.FT_OLAP_REGISTRATION_REPORTS.DIM_TEXTBOOK  AS dim_textbook ON f.dim_textbook_id = dim_textbook.DIM_TEXTBOOK_ID
    LEFT JOIN WEBASSIGN.FT_OLAP_REGISTRATION_REPORTS.DIM_DISCIPLINE  AS dim_discipline ON dim_textbook.dim_discipline_id = dim_discipline.DIM_DISCIPLINE_ID
    INNER JOIN WEBASSIGN.FT_OLAP_REGISTRATION_REPORTS.DIM_TIME  AS dim_time ON f.dim_time_id = dim_time.DIM_TIME_ID
    WHERE
          ((UPPER(dim_section.SECTION_INSTRUCTOR_EMAIL ) NOT LIKE UPPER( '%cengage%' ) AND UPPER( dim_section.SECTION_INSTRUCTOR_EMAIL ) NOT LIKE UPPER( '%webassign%' )
          AND UPPER( dim_section.SECTION_INSTRUCTOR_EMAIL ) NOT LIKE UPPER( '%openstax%' ) OR dim_section.SECTION_INSTRUCTOR_EMAIL IS NULL
          ))
      AND((
          UPPER( dim_school.COUNTRY_NAME )= UPPER( 'United States' ) OR UPPER( dim_school.COUNTRY_NAME )= UPPER( 'Canada' )
          ))
      AND((
          UPPER( dim_school.TYPE )= UPPER( 'Community College' )  OR UPPER( dim_school.TYPE )= UPPER( 'University' )
          ))
      AND((
          UPPER( dim_discipline.DISCIPLINE_NAME )= UPPER( 'Mathematics' )
          ))
      AND((UPPER( dim_time.TIMESCHOOLSEMESTERDESC )= UPPER( 'Fall15' )  OR UPPER( dim_time.TIMESCHOOLSEMESTERDESC )= UPPER( 'Fall16' ) OR UPPER( dim_time.TIMESCHOOLSEMESTERDESC )= UPPER( 'Fall17' ) OR UPPER( dim_time.TIMESCHOOLSEMESTERDESC )= UPPER( 'Fall18' )
          OR UPPER( dim_time.TIMESCHOOLSEMESTERDESC )= UPPER( 'Spring15' )  OR UPPER( dim_time.TIMESCHOOLSEMESTERDESC )= UPPER( 'Spring16' )  OR UPPER( dim_time.TIMESCHOOLSEMESTERDESC )= UPPER( 'Spring17' )  OR UPPER( dim_time.TIMESCHOOLSEMESTERDESC )= UPPER( 'Spring18' )
          OR UPPER( dim_time.TIMESCHOOLSEMESTERDESC )= UPPER( 'Summer15' )  OR UPPER( dim_time.TIMESCHOOLSEMESTERDESC )= UPPER( 'Summer16' )  OR UPPER( dim_time.TIMESCHOOLSEMESTERDESC )= UPPER( 'Summer17' ) OR UPPER( dim_time.TIMESCHOOLSEMESTERDESC )= UPPER( 'Summer18' )
          ))
--      AND((dim_textbook.DIM_TEXTBOOK_ID != '2220' AND dim_textbook.DIM_TEXTBOOK_ID is not null
--          ))
)
SELECT
        fact_registration_id||instructor_id as pk
      , *
FROM u
    ;;
  }

########################################################################### KEYS ####################################################################################

  dimension: pk                        { type: number group_label: "Foreign_keys" primary_key: yes}
  dimension: fact_registration_id      { type: number group_label: "Foreign_keys" primary_key: no}
  dimension: dim_time_id               { type: number group_label: "Foreign_keys" }
  dimension: dim_payment_method_id     { type: number group_label: "Foreign_keys" }
  dimension: dim_section_id            { type: number group_label: "Foreign_keys" hidden: no primary_key: no }
  dimension: dim_textbook_id           { type: number group_label: "Foreign_keys" }
  dimension: instructor_id             { type: number group_label: "Foreign_keys" }
  dimension: course_id                 { type: number group_label: "Foreign_keys" }
  dimension: dim_school_id             { type: number group_label: "Foreign_keys" }
  dimension: user_id                   { type: number group_label: "Foreign_keys" }
  dimension: dim_axscode_id            { type: number group_label: "Foreign_keys" }
  dimension: upgrades                  { type: number group_label: "Foreign_keys" }
  dimension: token_id                  { type: number group_label: "Foreign_keys" }
  dimension: school_id                 { type: number group_label: "Foreign_keys" }
  dimension: section_id                { type: number group_label: "Foreign_keys" primary_key: no }

########################################################################## USER DETAILS #############################################################################

  dimension: sso_guid                  { type: string group_label: "User Details"}
  dimension: username                  { type: string group_label: "User Details"}


######################################################################## AGGREGATIONS ###############################################################################


  dimension: redemption_model          { type: string group_label: "Sales Related" }
  dimension: event_type                { type: string group_label: "Sales Related" }
  dimension: purchase_type             { type: string group_label: "Sales Related" }
  dimension: gross_sales_revenue       { type: number group_label: "Sales Related" }
  dimension: net_sales_revenue         { type: number group_label: "Sales Related" }
  dimension: registrations             { type: number group_label: "Registrations" }
  dimension: registration_count        { type: number group_label: "Registrations" label: "Registration Count"}

  measure: user_registrations {
    label: "Number of Registrations (activations)"
    description: "Total Activations"
    type: sum_distinct
    sql_distinct_key: ${fact_registration_id} ;;
    sql: ${registrations} ;;

    drill_fields: [detail*]
  }

measure: count_all {
  type: count
}


}
