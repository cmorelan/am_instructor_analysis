include: "wa_dim_school.view.lkml"
include: "wa_fact_registration.view.lkml"
include: "am_opty_raw.view.lkml"

view: dim_institution {
    derived_table: {
      sql:
          SELECT
                distinct coalesce(os.entity_number, was.cl_entity_number) as dim_entity_no
              , os.entity_number as mag_entity_no
              , was.cl_entity_number as wa_entity_no
              , coalesce(os.account_name, was.name) as name
              , case when (mag_entity_no is not null AND wa_entity_no is not null) THEN 'Magellan & Webassign'
                      when (mag_entity_no is null AND wa_entity_no is not null) then 'WebAssign Only'
                      when (mag_entity_no is not null and wa_entity_no is null) then 'Magellan Only'
                      else 'Error'
                      END as join_description
          FROM DEV.ZCM.AM_OPTY_RAW as os
          FULL OUTER JOIN WEBASSIGN.FT_OLAP_REGISTRATION_REPORTS.DIM_SCHOOL as was on os.entity_number = was.cl_entity_number
          ;;
    }

    dimension: dim_entity_no {primary_key: yes}
    dimension: mag_entity_no {}
    dimension: wa_entity_no {}
    dimension: name {}
    dimension: join_description {}
    measure: count {
      type: count
    }

}
