view: wa_textbook_grtopic {
  view_label: "Discipline"
  sql_table_name: DEV.ZCM.WA_TEXTBOOK_GRTOPIC ;;


  dimension: wa_prod_code {
    type: string
    primary_key: yes
    hidden:  yes
    sql: ${TABLE}."WA_PROD_CODE" ;;
  }

  dimension:grouped_topic {
    label: "    Textbook Topic"
    description: "Derived field applying a textbook topic that is more granular than sub-discipline. Used to match topict taught by instructors across datasources for the Advanced Math cross-course Instructor Analysis Project"
#    group_label: "  Product Info"
    type: string
    sql: ${TABLE}."GROUPED_TOPIC" ;;
  }




}
