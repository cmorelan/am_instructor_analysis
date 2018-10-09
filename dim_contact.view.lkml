include: "wa_fact_registration.view.lkml"
include: "am_opty_raw.view.lkml"


############################  Currently Only Includes Joined Contacts ###############################################

view: dim_contact {
  derived_table: {
    sql:
  WITH o as (
        SELECT
              DISTINCT magellan_contact_id as mag_contact_id
            , entity_number as entity_no
            , contact_email as email
            , contact_first_name as fname
            , contact_last_name as lname
        FROM DEV.ZCM.AM_OPTY_RAW
    )
  , wds as (
        SELECT
              DISTINCT wds.instructor_id
            , sc.cl_entity_number as entity_no
            , wds.instructor_email as email
            , wds.instructor_fname as fname
            , wds.instructor_lname as lname
          FROM ${wa_dim_section.SQL_TABLE_NAME} as wds
          LEFT JOIN WEBASSIGN.FT_OLAP_REGISTRATION_REPORTS.DIM_SCHOOL as sc on wds.school_id = sc.school_id
    )
  , base as (  ------ Joins on email and entity number combo
        SELECT
              o.mag_contact_id||coalesce(wds.instructor_id,0) as dim_contact_id
            , o.mag_contact_id as mag_contact_id
            , wds.instructor_id as wa_instructor_id
            , coalesce(o.entity_no, wds.entity_no) as entity_no
            , coalesce(o.fname, wds.fname) as fname
            , coalesce(o.lname, wds.lname) as lname
            , coalesce(o.email, wds.email) as email
        FROM o
        FULL OUTER JOIN  wds  ON
                        lower(trim(o.email)) = lower(trim(wds.email))
                    AND o.entity_no = wds.entity_no
        WHERE (mag_contact_id is not null AND wa_instructor_id is not null)    ------ Where Statement Isolates so join strength and description can be added after the union
     )
   , j1 as ( ---------- Joins on email only
          SELECT
              o.mag_contact_id||coalesce(wds.instructor_id,0) as dim_contact_id
            , o.mag_contact_id as mag_contact_id
            , wds.instructor_id as wa_instructor_id
            , coalesce(o.entity_no, wds.entity_no) as entity_no
            , coalesce(o.fname, wds.fname) as fname
            , coalesce(o.lname, wds.lname) as lname
            , coalesce(o.email, wds.email) as email
        FROM o
        FULL OUTER JOIN  wds  ON
                        lower(trim(o.email)) = lower(trim(wds.email))
        WHERE (mag_contact_id is not null AND wa_instructor_id is not null)     ------ Where Statement Isolates so join strength and description can be added after the union
    )
   , j2 as ( ------------ Joins on Entity Number, First Initial, and Last Name (Need to adjust for instructors at the same institution with same combo (i.e. John Smith and Jane Smith)
          SELECT
              o.mag_contact_id||coalesce(wds.instructor_id,0) as dim_contact_id
            , o.mag_contact_id as mag_contact_id
            , wds.instructor_id as wa_instructor_id
            , coalesce(o.entity_no, wds.entity_no) as entity_no
            , coalesce(o.fname, wds.fname) as fname
            , coalesce(o.lname, wds.lname) as lname
            , coalesce(o.email, wds.email) as email
        FROM o
        FULL OUTER JOIN  wds  ON
                        o.entity_no = wds.entity_no
                    and upper(left(trim(o.fname),1)||trim(o.lname)) = upper(left(trim(wds.fname),1)||trim(wds.lname))
        WHERE (mag_contact_id is not null AND wa_instructor_id is not null)      ------ Where Statement Isolates so join strength and description can be added after the union
    )
 , un as (    --------------- Need to include a CTE to select all contacts that did not join
   SELECT *  FROM base
   UNION
   SELECT *  FROM j1
   UNION
   SELECT *  FROM j2
  )
  select
     un.*
    , CASE
          WHEN un.dim_contact_id = base.dim_contact_id then 'Very Strong'
          WHEN un.dim_contact_id = j1.dim_contact_id then 'Strong'
          WHEN un.dim_contact_id = j2.dim_contact_id then 'Weak'
          ELSE 'Not Joined'
      END AS join_confidence
    , CASE
          WHEN un.dim_contact_id = base.dim_contact_id then 'ON Entity-Email'
          WHEN un.dim_contact_id = j1.dim_contact_id then 'ON Email'
          WHEN un.dim_contact_id = j2.dim_contact_id then 'ON Entity-First Initial, LName'
          ELSE 'Not Joined'
      END AS join_description
  FROM un
  LEFT JOIN base on un.dim_contact_id = base.dim_contact_id
  LEFT JOIN j1 on un.dim_contact_id = j1.dim_contact_id
  LEFT JOIN j2 on un.dim_contact_id = j2.dim_contact_id
    ;;
  }
  dimension: dim_contact_id {}
  dimension: mag_contact_id {}
  dimension: wa_instructor_id {}
  dimension: fname {}
  dimension: lname {}
  dimension: entity_no {}
  dimension: email {}
  dimension: join_confidence {}
 dimension: join_description {}
measure: count {
  type: count

}

 }
