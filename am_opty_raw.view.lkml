view: am_opty_raw {
  sql_table_name: DEV.ZCM.AM_OPTY_RAW ;;

  dimension: account_category {
    type: string
    sql: ${TABLE}."ACCOUNT_CATEGORY" ;;
  }

  dimension: account_name {
    type: string
    sql: ${TABLE}."ACCOUNT_NAME" ;;
  }

  dimension: account_type {
    type: string
    sql: ${TABLE}."ACCOUNT_TYPE" ;;
  }

  dimension: address_1 {
    type: string
    sql: ${TABLE}."ADDRESS_1" ;;
  }

  dimension: address_2 {
    type: string
    sql: ${TABLE}."ADDRESS_2" ;;
  }

  dimension: address_3 {
    type: string
    sql: ${TABLE}."ADDRESS_3" ;;
  }

  dimension: biu_type {
    type: string
    sql: ${TABLE}."BIU_TYPE" ;;
  }

  dimension: book_grabber {
    type: string
    sql: ${TABLE}."BOOK_GRABBER" ;;
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}."CAMPAIGN_NAME" ;;
  }

  dimension: cengage_course_code_ct {
    type: string
    sql: ${TABLE}."CENGAGE_COURSE_CODE_CT" ;;
  }

  dimension: cengage_course_description_ct {
    type: string
    sql: ${TABLE}."CENGAGE_COURSE_DESCRIPTION_CT" ;;
  }

  dimension: cengage_discipline_ct {
    type: string
    sql: ${TABLE}."CENGAGE_DISCIPLINE_CT" ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}."CITY" ;;
  }

  dimension: considering_oer {
    type: string
    sql: ${TABLE}."CONSIDERING_OER" ;;
  }

  dimension: contact_activity_code {
    type: string
    sql: ${TABLE}."CONTACT_ACTIVITY_CODE" ;;
  }

  dimension: contact_comp_author {
    type: string
    sql: ${TABLE}."CONTACT_COMP_AUTHOR" ;;
  }

  dimension: contact_email {
    type: string
    sql: ${TABLE}."CONTACT_EMAIL" ;;
  }

  dimension: contact_first_name {
    type: string
    sql: ${TABLE}."CONTACT_FIRST_NAME" ;;
  }

  dimension: contact_last_name {
    type: string
    sql: ${TABLE}."CONTACT_LAST_NAME" ;;
  }

  dimension: contact_promo_code {
    type: string
    sql: ${TABLE}."CONTACT_PROMO_CODE" ;;
  }

  dimension: contact_role {
    type: string
    sql: ${TABLE}."CONTACT_ROLE" ;;
  }

  dimension: contact_seg_email_type {
    type: string
    sql: ${TABLE}."CONTACT_SEG_EMAIL_TYPE" ;;
  }

  dimension: contact_type {
    type: string
    sql: ${TABLE}."CONTACT_TYPE" ;;
  }

  dimension: contact_work_phone_number {
    type: string
    sql: ${TABLE}."CONTACT_WORK_PHONE_NUMBER" ;;
  }

  dimension: contacts_with_bounced_email_flag {
    type: string
    sql: ${TABLE}."CONTACTS_WITH_BOUNCED_EMAIL_FLAG" ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}."COUNTRY" ;;
  }

  dimension: course_piu_author {
    type: string
    sql: ${TABLE}."COURSE_PIU_AUTHOR" ;;
  }

  dimension: course_piu_isbn13 {
    type: string
    sql: ${TABLE}."COURSE_PIU_ISBN13" ;;
  }

  dimension: course_piu_title {
    type: string
    sql: ${TABLE}."COURSE_PIU_TITLE" ;;
  }

  dimension: degree {
    type: string
    sql: ${TABLE}."DEGREE" ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}."DEPARTMENT" ;;
  }

  dimension: dm {
    type: string
    sql: ${TABLE}."DM" ;;
  }

  dimension: ed_recommended_rev_flag {
    type: string
    sql: ${TABLE}."ED_RECOMMENDED_REV_FLAG" ;;
  }

  dimension: entity_number {
    type: number
    sql: ${TABLE}."ENTITY_NUMBER" ;;
  }

  dimension: estimated_enrollment {
    type: number
    sql: ${TABLE}."ESTIMATED_ENROLLMENT" ;;
  }

  dimension: implementation_priority {
    type: string
    sql: ${TABLE}."IMPLEMENTATION_PRIORITY" ;;
  }

  dimension: institution_course_name_ct {
    type: string
    sql: ${TABLE}."INSTITUTION_COURSE_NAME_CT" ;;
  }

  dimension: magellan_account_id {
    type: string
    sql: ${TABLE}."MAGELLAN_ACCOUNT_ID" ;;
  }

  dimension: magellan_contact_id {
    type: string
    sql: ${TABLE}."MAGELLAN_CONTACT_ID" ;;
  }

  dimension: magellan_opty_row_id {
    type: string
    sql: ${TABLE}."MAGELLAN_OPTY_ROW_ID" ;;
  }

  dimension: major_market_code {
    type: string
    sql: ${TABLE}."MAJOR_MARKET_CODE" ;;
  }

  dimension: major_market_description {
    type: string
    sql: ${TABLE}."MAJOR_MARKET_DESCRIPTION" ;;
  }

  dimension: market_code {
    type: string
    sql: ${TABLE}."MARKET_CODE" ;;
  }

  dimension: opportunity_total_revenue {
    type: number
    sql: ${TABLE}."OPPORTUNITY_TOTAL_REVENUE" ;;
  }

  dimension: opportunity_total_revenue_ct {
    type: number
    sql: ${TABLE}."OPPORTUNITY_TOTAL_REVENUE_CT" ;;
  }

  dimension: opportunity_total_units {
    type: number
    sql: ${TABLE}."OPPORTUNITY_TOTAL_UNITS" ;;
  }

  dimension: opportunity_total_units_ct {
    type: number
    sql: ${TABLE}."OPPORTUNITY_TOTAL_UNITS_CT" ;;
  }

  dimension: opportunity_type {
    type: string
    sql: ${TABLE}."OPPORTUNITY_TYPE" ;;
  }

  dimension: opty_exists_flag {
    type: string
    sql: ${TABLE}."OPTY_EXISTS_FLAG" ;;
  }

  dimension: opty_product_considered_author {
    type: string
    sql: ${TABLE}."OPTY_PRODUCT_CONSIDERED_AUTHOR" ;;
  }

  dimension: opty_product_considered_isbn13 {
    type: string
    sql: ${TABLE}."OPTY_PRODUCT_CONSIDERED_ISBN13" ;;
  }

  dimension: opty_product_considered_title {
    type: string
    sql: ${TABLE}."OPTY_PRODUCT_CONSIDERED_TITLE" ;;
  }

  dimension: opty_sales_period {
    type: string
    sql: ${TABLE}."OPTY_SALES_PERIOD" ;;
  }

  dimension: opty_stage {
    type: string
    sql: ${TABLE}."OPTY_STAGE" ;;
  }

  dimension: opty_status {
    type: string
    sql: ${TABLE}."OPTY_STATUS" ;;
  }

  dimension: organization_id {
    type: string
    sql: ${TABLE}."ORGANIZATION_ID" ;;
  }

  dimension: organization_name {
    type: string
    sql: ${TABLE}."ORGANIZATION_NAME" ;;
  }

  dimension: piu_author {
    type: string
    sql: ${TABLE}."PIU_AUTHOR" ;;
  }

  dimension: piu_isbn13 {
    type: string
    sql: ${TABLE}."PIU_ISBN13" ;;
  }

  dimension: piu_title {
    type: string
    sql: ${TABLE}."PIU_TITLE" ;;
  }

  dimension: product_quantity {
    type: number
    sql: ${TABLE}."PRODUCT_QUANTITY" ;;
  }

  dimension: product_revenue {
    type: number
    sql: ${TABLE}."PRODUCT_REVENUE" ;;
  }

  dimension: rep_recommended_rev_flag {
    type: string
    sql: ${TABLE}."REP_RECOMMENDED_REV_FLAG" ;;
  }

  dimension: reviewer {
    type: string
    sql: ${TABLE}."REVIEWER" ;;
  }

  dimension: rm {
    type: string
    sql: ${TABLE}."RM" ;;
  }

  dimension: sales_rep_name {
    type: string
    sql: ${TABLE}."SALES_REP_NAME" ;;
  }

  dimension: salutation {
    type: string
    sql: ${TABLE}."SALUTATION" ;;
  }

  dimension: sampled_isbn13 {
    type: string
    sql: ${TABLE}."SAMPLED_ISBN13" ;;
  }

  dimension: sampled_product_family {
    type: string
    sql: ${TABLE}."SAMPLED_PRODUCT_FAMILY" ;;
  }

  dimension: sampled_title {
    type: string
    sql: ${TABLE}."SAMPLED_TITLE" ;;
  }

  dimension: sampled_title_major_code {
    type: string
    sql: ${TABLE}."SAMPLED_TITLE_MAJOR_CODE" ;;
  }

  dimension: sampled_title_major_description {
    type: string
    sql: ${TABLE}."SAMPLED_TITLE_MAJOR_DESCRIPTION" ;;
  }

  dimension: sampled_title_minor_code {
    type: string
    sql: ${TABLE}."SAMPLED_TITLE_MINOR_CODE" ;;
  }

  dimension: sampled_title_minor_description {
    type: string
    sql: ${TABLE}."SAMPLED_TITLE_MINOR_DESCRIPTION" ;;
  }

  dimension: semester_used_ct {
    type: string
    sql: ${TABLE}."SEMESTER_USED_CT" ;;
  }

  dimension: stage_ct {
    type: string
    sql: ${TABLE}."STAGE_CT" ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}."STATE" ;;
  }

  dimension: status_ct {
    type: string
    sql: ${TABLE}."STATUS_CT" ;;
  }

  dimension: suppress_call_flag {
    type: string
    sql: ${TABLE}."SUPPRESS_CALL_FLAG" ;;
  }

  dimension: suppress_email_flag {
    type: string
    sql: ${TABLE}."SUPPRESS_EMAIL_FLAG" ;;
  }

  dimension: suppress_email_until {
    type: string
    sql: ${TABLE}."SUPPRESS_EMAIL_UNTIL" ;;
  }

  dimension: suppress_mail_flag {
    type: string
    sql: ${TABLE}."SUPPRESS_MAIL_FLAG" ;;
  }

  dimension: supress_mass_email_flag {
    type: string
    sql: ${TABLE}."SUPRESS_MASS_EMAIL_FLAG" ;;
  }

  dimension: tech_product_concat {
    type: string
    sql: ${TABLE}."TECH_PRODUCT_CONCAT" ;;
  }

  dimension: technology {
    type: string
    sql: ${TABLE}."TECHNOLOGY" ;;
  }

  dimension: technology_product_code_description {
    type: string
    sql: ${TABLE}."TECHNOLOGY_PRODUCT_CODE_DESCRIPTION" ;;
  }

  dimension: technology_required {
    type: string
    sql: ${TABLE}."TECHNOLOGY_REQUIRED" ;;
  }

  dimension: techology_product_code {
    type: string
    sql: ${TABLE}."TECHOLOGY_PRODUCT_CODE" ;;
  }

  dimension: territory {
    type: string
    sql: ${TABLE}."TERRITORY" ;;
  }

  dimension: zipcode {
    type: zipcode
    sql: ${TABLE}."ZIPCODE" ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      account_name,
      contact_first_name,
      contact_last_name,
      organization_name,
      sales_rep_name,
      campaign_name
    ]
  }
}
