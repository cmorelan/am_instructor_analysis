#  include: "/webassign/dim_section.view.lkml"
#  include: "/webassign/dim_discipline.view.lkml"
#  include: "/webassign/fact_registration.view.lkml"
#  include: "am_wa_contact_namesparsed.view.lkml"
#  include: "instructor_analysi*.model.lkml"


# view: wa_fact_registration {
#   extends: [fact_registration]
#   derived_table: {
#     sql:
# WITH u AS (--
#   SELECT
#         f.FACT_REGISTRATION_ID
#       , f.DIM_TIME_ID
#       , f.NET_SALES_REVENUE
#       , f.DIM_PAYMENT_METHOD_ID
#       , f.UPGRADES
#       , f.DIM_SECTION_ID
#       , f.SSO_GUID
#       , f.REDEMPTION_MODEL
#       , f.EVENT_TYPE
#       , f.TOKEN_ID
#       , f.SCHOOL_ID
#       , f.SECTION_ID
# --      , sec.DIM_DISCIPLINE_ID AS SECTION_DIM_DISCIPLINE_ID
#       , f.DIM_TEXTBOOK_ID
#  --     , t.DIM_DISCIPLINE_ID AS TEXTBOOK_DIM_DISCIPLINE_ID
#       , f.PURCHASE_TYPE
#       , f.COURSE_ID
#       , f.GROSS_SALES_REVENUE
#       , f.REGISTRATIONS
#       , f.COUNT AS NUM_REGISTRATIONS
#       , f.COURSE_INSTRUCTOR_ID AS INSTRUCTOR_ID
#       , f.DIM_SCHOOL_ID
#       , f.USER_ID
#       , f.DIM_AXSCODE_ID
#       , f.USERNAME
#     FROM WEBASSIGN.FT_OLAP_REGISTRATION_REPORTS.FACT_REGISTRATION AS f
# --    LEFT JOIN ${dim_section.SQL_TABLE_NAME} AS sec ON f.DIM_SECTION_ID = sec.DIM_SECTION_ID
# --    LEFT JOIN ${dim_school.SQL_TABLE_NAME} sch ON f.DIM_SCHOOL_ID = sch.DIM_SCHOOL_ID--WEBASSIGN.FT_OLAP_REGISTRATION_REPORTS.DIM_SCHOOL  AS sch
# --    LEFT JOIN ${dim_textbook.SQL_TABLE_NAME} t ON f.DIM_TEXTBOOK_ID = t.DIM_TEXTBOOK_ID ----WEBASSIGN.FT_OLAP_REGISTRATION_REPORTS.DIM_TEXTBOOK  AS t
# --    WHERE (sec.DIM_DISCIPLINE_ID IN (54,18,21,15,20,19,51,48,16,17,2) OR T.DIM_DISCIPLINE_ID IN (54,18,21,15,20,19,51,48,16,17,2))
# UNION
#   SELECT
#         f.FACT_REGISTRATION_ID
#       , f.DIM_TIME_ID
#       , f.NET_SALES_REVENUE
#       , f.DIM_PAYMENT_METHOD_ID
#       , f.UPGRADES
#       , f.DIM_SECTION_ID
#       , f.SSO_GUID
#       , f.REDEMPTION_MODEL
#       , f.EVENT_TYPE
#       , f.TOKEN_ID
#       , f.SCHOOL_ID
#       , f.SECTION_ID
# --       , sec.DIM_DISCIPLINE_ID AS SECTION_DIM_DISCIPLINE_ID
#       , f.DIM_TEXTBOOK_ID
# --      , t.DIM_DISCIPLINE_ID AS TEXTBOOK_DIM_DISCIPLINE_ID
#       , f.PURCHASE_TYPE
#       , f.COURSE_ID
#       , f.GROSS_SALES_REVENUE
#       , f.REGISTRATIONS
#       , f.COUNT AS NUM_REGISTRATIONS
#       , f.SECTION_INSTRUCTOR_ID AS INSTRUCTOR_ID
#       , f.DIM_SCHOOL_ID
#       , f.USER_ID
#       , f.DIM_AXSCODE_ID
#       , f.USERNAME
#     FROM WEBASSIGN.FT_OLAP_REGISTRATION_REPORTS.FACT_REGISTRATION AS f
# --    LEFT JOIN ${dim_section.SQL_TABLE_NAME} AS sec ON f.DIM_SECTION_ID = sec.DIM_SECTION_ID
# --    LEFT JOIN ${dim_school.SQL_TABLE_NAME} sch ON f.DIM_SCHOOL_ID = sch.DIM_SCHOOL_ID--WEBASSIGN.FT_OLAP_REGISTRATION_REPORTS.DIM_SCHOOL  AS sch
# --    LEFT JOIN ${dim_textbook.SQL_TABLE_NAME} t ON f.DIM_TEXTBOOK_ID = t.DIM_TEXTBOOK_ID ----WEBASSIGN.FT_OLAP_REGISTRATION_REPORTS.DIM_TEXTBOOK  AS t
# --    WHERE (sec.DIM_DISCIPLINE_ID IN (54,18,21,15,20,19,51,48,16,17,2) OR T.DIM_DISCIPLINE_ID IN (54,18,21,15,20,19,51,48,16,17,2))
# )
# SELECT
#         fact_registration_id||instructor_id as pk
#       , *
# FROM u
#     ;;
#   }
#
#   dimension: pk {type: number primary_key: yes}
#   dimension: fact_registration_id { type: number primary_key: no}
#   dimension: dim_time_id { type: number }
#   dimension: net_sales_revenue { type: number }
#   dimension: dim_payment_method_id { type: number }
#   dimension: upgrades { type: number }
#   dimension: dim_section_id { type: number }
#   dimension: sso_guid { type: string }
#   dimension: redemption_model { type: string }
#   dimension: event_type { type: string }
#   dimension: token_id { type: number }
#   dimension: school_id { type: number }
#   dimension: section_id { type: number }
# #   dimension: section_dim_discipline_id { type: number }
#   dimension: dim_textbook_id { type: number }
# #   dimension: textbook_dim_discipline_id { type: number }
#   dimension: purchase_type { type: string }
#   dimension: course_id { type: number }
#   dimension: gross_sales_revenue { type: number }
#   dimension: registrations { type: number }
#   dimension: num_registrations { type: number }
#   dimension: instructor_id { type: number }
#   dimension: dim_school_id { type: number }
#   dimension: user_id { type: number }
#   dimension: dim_axscode_id { type: number }
#   dimension: username { type: string }
#
#
# }
