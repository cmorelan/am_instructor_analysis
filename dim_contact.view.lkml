include: "wa_fact_registration.view.lkml"
include: "am_opty_raw.view.lkml"


############################  Currently Only Includes Joined Contacts ###############################################

view: dim_contact {
  derived_table: {
    sql:
--#############################################################################################################################################################################################################--
--#############  1. PULLING IN NEEDED FIELDS FROM SOURCE TABLES  ##############################################################################################################################################--
--#############################################################################################################################################################################################################--
WITH o_base as (
         SELECT
               DISTINCT CAST(magellan_contact_id as STRING) as mag_contact_id
             , entity_number as entity_no
             , lower(trim(contact_email)) as email
             , upper(trim(contact_first_name)) as fname
             , upper(trim(contact_last_name)) as lname
         FROM DEV.ZCM.AM_OPTY_RAW
) , wa as (
         SELECT
               DISTINCT CAST(wds.instructor_id as string) as wa_instructor_id
             , sc.cl_entity_number as entity_no
             , lower(trim(wds.instructor_email)) as email
             , upper(trim(wds.instructor_fname)) as fname
             , upper(trim(wds.instructor_lname)) as lname
           FROM ${wa_dim_section.SQL_TABLE_NAME} as wds
           LEFT JOIN WEBASSIGN.FT_OLAP_REGISTRATION_REPORTS.DIM_SCHOOL as sc on wds.school_id = sc.school_id
           WHERE wds.dim_discipline_id in (2, 9, 15, 16, 17, 18, 19, 20, 21, 36, 37, 38, 39, 48, 51, 54, 55)
           AND wds.instructor_fname is not null
           AND wds.instructor_lname is not null
--#############################################################################################################################################################################################################--
--#############  2. cLEANING UP WEBASSIGN CONTACTS:                                                                                     #######################################################################--
--#############      -> WA_SETUP IDENTIFIES WEBASSIGN CONTACTS WITH MULTIPLE RECORDS TO BE EXCLUDED FORM CERTAIN JOINS                  #######################################################################--
--#############      -> WA_MULTI_EMAIL_SETUP SELF JOINS CONTACTS WITH >1 EMAIL ON SAME LINE TO IF ANY JOIN OPTY                         #######################################################################--
--#############      -> WA_MULTI_EMAIL_SETUP_2 ADDS ROW_NUMBER TO FILTER OUT DUPLICATE ROWS (A-B & B-A)                                 #######################################################################--
--#############      -> WA_MULTI_EMAIL_JOIN_1&2 BREAK OUT MULTIPLE EMAILS INTO SEPERATE TABLES AND JOINS WITH OPTY                      #######################################################################--
--#############      -> WA_MULTI_EMAIL_SELECTION IDENTIFIES WHICH EMAIL(S) (IF ANY) JOIN TO OPTY & FILTERS OUT DUPLICATE ROWS           #######################################################################--
--#############      -> WA_MULTI_EMAIL TAKES JOINABLE EMAILS AND NAMES AND UNPIVOTS THEM BACK INTO ONE COLUMN, 1 RECORD PER ID          #######################################################################--
--#############      -> WA_BASE UNIONS TOGETHER CONTACTS WITH SINGLE RECORD AND MULTI-EMAIL ADDRESSES & IS THE MAIN CTE MOVING FORWARD  #######################################################################--
--#############################################################################################################################################################################################################--
) , wa_setup as (                                            --- IDENTIFIES WEBASSIGN CONTACTS WITH MULTIPLE RECORDS TO BE EXCLUDED FORM CERTAIN JOINS
        select
              wa.*
            , coalesce(case when count(*) OVER (PARTITION BY wa.wa_instructor_id) = 1 THEN 'Single Record' else null end --as num_records_for_id
                       , case when count(*) over (partition by wa.wa_instructor_id||wa.fname||wa.lname||wa.entity_no) > 1 then 'Multiple Emails' else null end --as multi_record_name
                       , case when count(*) over (partition by wa.wa_instructor_id||wa.entity_no||wa.email) >1 then 'Multiple Names' else null end -- as multi_record_entity
                       , case when count(*) over (partition by wa.wa_instructor_id||wa.email||wa.fname||wa.lname) >1 then 'Multiple Institutions' else null end -- as multi_record_email
                       , case when count(*) over (partition by wa.wa_instructor_id||wa.entity_no) > 1 then 'Multiple Emails & Names' else null end --as multi_record_name
                       , case when count(*) over (partition by wa.wa_instructor_id||wa.fname||wa.lname) > 1 then 'Multiple Emails & Institutions' else null end --as multi_record_name
                       , case when count(*) over (partition by wa.wa_instructor_id||wa.email) > 1 then 'Multiple Names & Institutions' else null end --as multi_record_name
                      ) as contact_id_records
        from wa
        where wa.email is not null
) , wa_multi_email_setup_2 as (                              --- SELF JOINING TABLE TO GET MULTI EMAIL CONTACTS'S MULTIPLE EMAILS ON THE SAME ROW. ROW NUMBER USED TO REMOVE DUPLICATES (EMAIL_1-EMAIL_2 & EMAIL_2-EMAIL_1)
        SELECT
              *
            , ROW_NUMBER() OVER (PARTITION BY wa_instructor_id ORDER BY email1) as rn
        FROM (                                               --- SELF JOINS CONTACTS WITH >1 EMAIL ON SAME LINE TO IF ANY JOIN OPTY
        SELECT
              DISTINCT A.wa_instructor_id AS wa_instructor_id
            , UPPER(TRIM(A.fname||' '||A.lname))  AS fullname1
            , UPPER(TRIM(A.fname))  AS fname1
            , UPPER(TRIM(A.lname))  AS lname1
            , LOWER(TRIM(A.email))  AS email1
            , UPPER(TRIM(B.fname||' '||B.lname))  AS fullname2
            , UPPER(TRIM(B.fname))  AS fname2
            , UPPER(TRIM(B.lname))  AS lname2
            , LOWER(TRIM(B.email))  AS email2
        FROM WA_SETUP A, WA_SETUP B
        WHERE A.wa_instructor_id = B.wa_instructor_id
        AND UPPER(TRIM(A.email)) <> UPPER(TRIM(B.email))
        AND (A.contact_id_records ='Multiple Emails' OR B.contact_id_records = 'Multiple Emails')
              ) mult_email_setup
) , wa_multi_email_join_1 as (                              --BREAK OUT MULTIPLE EMAILS INTO SEPERATE TABLES TO BE UNPIVOTED AND JOINS WITH OPTY
        SELECT
              mes2.*
            , o_base.mag_contact_id as mag_contact_id
        FROM wa_multi_email_setup_2  mes2
        LEFT JOIN o_base on mes2.email1=o_base.email       --- TARGETS EMAIL_1 FROM SETUP TABLE
        WHERE mes2.rn =1                                   --- ONLY SELECTS ROW 1 FOR EACH ID TO REMOVE DUPLICATE DATA ROWS
) , wa_multi_email_join_2 as (
        SELECT
              mes2.*
            , o_base.mag_contact_id as mag_contact_id
        FROM wa_multi_email_setup_2  mes2
        LEFT JOIN o_base on mes2.email2=o_base.email       --- TARGETS EMAIL_2 FROM SETUP TABLE
        WHERE mes2.rn =1                                   --- ONLY SELECTS ROW 1 FOR EACH ID TO REMOVE DUPLICATE DATA ROWS
) , wa_multi_email_selection as (                          --- IDENTIFIES WHICH EMAIL(S) (IF ANY) JOIN TO OPTY & FILTERS OUT DUPLICATE ROWS
        SELECT
              mes2.*
            , mej1.mag_contact_id as mag_contact_id1
            , mej2.mag_contact_id as mag_contact_id2
            , CASE WHEN (mag_contact_id1 is not null AND mag_contact_id2 is not null) THEN 'Both Emails Join'
                   WHEN (mag_contact_id1 is not null AND mag_contact_id2 is null) THEN 'Match on Email_1'
                   WHEN (mag_contact_id1 is null AND mag_contact_id2 is not null) THEN 'Match on Email_2'
                   WHEN (mag_contact_id1 is null AND mag_contact_id2 is null) THEN 'No Email Match'
                  ELSE 'ERROR'
                  END as multi_email_join_desc
        FROM wa_multi_email_setup_2  mes2
        LEFT JOIN wa_multi_email_join_1 mej1 ON mes2.wa_instructor_id = mej1.wa_instructor_id
        LEFT JOIN wa_multi_email_join_2 mej2 on mes2.wa_instructor_id = mej2.wa_instructor_id
        WHERE mes2.rn =1
) , wa_multi_email as (                                     --- TAKES JOINABLE EMAILS AND NAMES AND UNPIVOTS THEM BACK INTO ONE COLUMN, 1 RECORD PER ID
        SELECT
              coalesce(mes.mag_contact_id1,mes.mag_contact_id2) as mag_contact_id
            , mes.wa_instructor_id
            , wa.entity_no
            , CASE WHEN mes.mag_contact_id1 is not null THEN mes.email1
                   WHEN mes.mag_contact_id2 is not null then mes.email2
                   ELSE 'ERROR'
                END as email
            , CASE WHEN mes.mag_contact_id1 is not null THEN mes.fname1
                   WHEN mes.mag_contact_id2 is not null then mes.fname2
                   ELSE 'ERROR'
                END as fname
            , CASE WHEN mes.mag_contact_id1 is not null THEN mes.lname1
                   WHEN mes.mag_contact_id2 is not null then mes.lname2
                   ELSE 'ERROR'
                END as lname
        FROM wa_multi_email_selection mes
        LEFT JOIN wa on mes.wa_instructor_id||email = wa.wa_instructor_id||email
        WHERE mes.multi_email_join_desc <> 'No Email Match'
) , wa_base as ( ---------Unions together the single record contacts and the multi-email contacts filtered to only include 1 record that is known to join with opty
        SELECT
              was.wa_instructor_id as wa_instructor_id
            , was.entity_no as entity_no
            , was.email as email
            , was.fname as fname
            , was.lname as lname
            , was.contact_id_records as contact_id_records
        FROM wa_setup was
        WHERE was.contact_id_records in ('Single Record', 'Multiple Institutions')
      UNION
        SELECT
              wme.wa_instructor_id as wa_instructor_id
            , wme.entity_no as entity_no
            , wme.email as email
            , wme.fname as fname
            , wme.lname as lname
            , 'Multiple Emails' as contact_id_records
        FROM wa_multi_email wme
)
--#############################################################################################################################################################################################################--
--#############  3. JOINING OPTY TABLE TO WEBASSIGN                                                                                       #####################################################################--
--#############      -> J1 JOINS ON EMAIL ID ONLY                                                                                         #####################################################################--
--#############      -> J2 JOINS ON ENTITY NUMBER, FIRST INITIAL, AND LAST NAME (NEED TO REMOVE CONTACTS THAT MAY APPEAR TO BE THE SAME)  #####################################################################--
--#############      (*) REMOVED JOIN ON ENTITY + EMAIL SINCE DONT WANT TO SEPERATE A CONTACT INTO TWO IF TEACHING DIFFERENT SCHOOLS      #####################################################################--
--#############                                                                                                                           #####################################################################--
--############# *** SPECIAL NOTE: INITIAL JOINS NEED TO PULL ONLY MATCHES (RATHER THAN USING FULL OUTER JOIN) SO THEY CAN BE TAGGED BY    #####################################################################--
--#############                   HOW THEY WERE MATCHED AND ALSO TO PREVENT THE SAME CONTACT BEING DUPLICATED AS A MATCH AS WELL AS       #####################################################################--
--#############                   A NON MATCHED RECORD DUE TO MULTIPLE JOIN LOGICS. THEN PULL IN THE RECORDS THAT ARE UNIQUE TO THEIR     #####################################################################--
--#############                   SOURCE AFTER THE FACT                                                                                   #####################################################################--
--#############################################################################################################################################################################################################--
, j1 as (                                                                        --- Joins on email only
           SELECT
               coalesce(o_base.mag_contact_id,'')||coalesce(wa_base.wa_instructor_id,'') as dim_contact_id
             , o_base.mag_contact_id as mag_contact_id
             , wa_base.wa_instructor_id as wa_instructor_id
             , coalesce(o_base.entity_no, wa_base.entity_no) as entity_no
             , coalesce(o_base.fname, wa_base.fname) as fname
             , coalesce(o_base.lname, wa_base.lname) as lname
             , coalesce(o_base.email, wa_base.email) as email
             , wa_base.contact_id_records as contact_id_records
             , CASE WHEN (mag_contact_id IS NOT NULL AND wa_instructor_id IS NOT NULL) THEN 'Strong'
                    ELSE 'Not Joined'
                 END as join_confidence
             , CASE WHEN (mag_contact_id IS NOT NULL AND wa_instructor_id IS NOT NULL) THEN 'ON Email'
                    ELSE 'Not Joined'
                 END as join_description
         FROM o_base
         inner join  wa_base  ON
                         lower(trim(o_base.email)) = lower(trim(wa_base.email))
--         WHERE ( wa_base.email is not null                                         --- Where Statement Isolates so join strength and description can be added after the union
--                AND wa_base.email != ''
--              AND mag_contact_id is not null AND wa_instructor_id is not null
--               )
    )
    , j2 as (                                                                      --- Joins on Entity Number, First Initial, and Last Name
                                                                                   --- Need to adjust for instructors at the same institution with same combo (i.e. John Smith and Jane Smith)
                                                                                   --- Also need to adjust for contacts names with multiple contact_ids
           SELECT
               coalesce(o_base.mag_contact_id,'')||coalesce(wa_base.wa_instructor_id,'') as dim_contact_id
             , o_base.mag_contact_id as mag_contact_id
             , wa_base.wa_instructor_id as wa_instructor_id
             , coalesce(o_base.entity_no, wa_base.entity_no) as entity_no
             , coalesce(o_base.fname, wa_base.fname) as fname
             , coalesce(o_base.lname, wa_base.lname) as lname
             , coalesce(o_base.email, wa_base.email) as email
             , wa_base.contact_id_records as contact_id_records
             , CASE WHEN (mag_contact_id IS NOT NULL AND wa_instructor_id IS NOT NULL) THEN 'Weak'
                    ELSE 'Not Joined'
                 END as join_confidence
             , CASE WHEN (mag_contact_id IS NOT NULL AND wa_instructor_id IS NOT NULL) THEN 'ON Entity-First Initial-Lname'
                    ELSE 'Not Joined'
                 END as join_description
         FROM o_base
         INNER JOIN  wa_base  ON (o_base.entity_no = wa_base.entity_no AND upper(left(trim(o_base.fname),1)||trim(o_base.lname)) = upper(left(trim(wa_base.fname),1)||trim(wa_base.lname)))
--         WHERE (wa_base.fname is not null AND wa_base.lname is not null
--              AND mag_contact_id is not null AND wa_instructor_id is not null         --- Where Statement Isolates so join strength and description can be added after the union
--              AND wa_base.contact_id_records = 'Single Record'
--               )
    )
--#############################################################################################################################################################################################################--
--#############  4. UNIONING JOINED TABLES & REMOVING DUPLICATE ROWS                                                                      #####################################################################--
--#############      -> UN - PRIORITIZES CONTACTS WITH JOIN ON EMAIL ADDRESS BY PULLING THEM IN FIRST AND THEN THE CONTACTS JOINED BY     #####################################################################--
--#############              ENTITY-NAME ARE ONLY PULLED IN IF NOT EXISTING IN FIRST JOIN                                                 #####################################################################--
--#############      -> J2 JOINS ON ENTITY NUMBER, FIRST INITIAL, AND LAST NAME (NEED TO REMOVE CONTACTS THAT MAY APPEAR TO BE THE SAME)  #####################################################################--
--#############      (*) REMOVED JOIN ON ENTITY + EMAIL SINCE DONT WANT TO SEPERATE A CONTACT INTO TWO IF TEACHING DIFFERENT SCHOOLS      #####################################################################--
--#############################################################################################################################################################################################################--
  , union_matches as (                                                                   --- Need to include a CTE to select all contacts that did not join
         SELECT                                                                 --- FIRST PART PRIORITIZES EMAIL JOIN AND PULLS IN ALL MATCHED CONTACTS ON EMAIL ONLY
                j1.dim_contact_id as dim_contact_id
              , j1.mag_contact_id as mag_contact_id
              , j1.wa_instructor_id as wa_instructor_id
              , j1.entity_no as entity_no
              , j1.fname as fname
              , j1.lname as lname
              , j1.email as email
              , 'Strong' as join_confidence
              , 'ON Email' as join_description
         FROM j1
    UNION
         SELECT                                                                 --- 2ND PART PULLS MACHES ON ENTITY-NAME ONLY IF THEY WERE NOT ALREADY MATCHED ABOVE- PREVENTS DUPLICATE RECORDS THAT MATCH IN BOTH JOINS
                j2.dim_contact_id as dim_contact_id
              , j2.mag_contact_id as mag_contact_id
              , j2.wa_instructor_id as wa_instructor_id
              , j2.entity_no as entity_no
              , j2.fname as fname
              , j2.lname as lname
              , j2.email as email
              , 'Weak' as join_confidence
              , 'ON Entity-First Initial-Lname' as join_description
         FROM j2
         LEFT JOIN j1 ON j2.dim_contact_id = j1.dim_contact_id                  --- LEFT JOIN WITH WHERE ON J1.DIM_CONTACT_ID SELECTS CONTACTS THAT ARE NOT IN THE ORIGINAL TABLE
         WHERE j1.dim_contact_id is null
--           WHERE (j1.mag_contact_id is null or j1.wa_instructor_id is null)
), un_mag as (                                                                     --- UNIONS MATCHES WITH UNIQUE TO SOURCE CONTACTS
         SELECT                                                                 --- MATCHES FROM CTE ABOVE
              um.*
         FROM union_matches um
    UNION
         SELECT                                                                 --- PULLS IN MAGELLAN CONTACTS NOT MATCHED ABOVE
               DISTINCT o.mag_contact_id AS dim_contact_id
             , o.mag_contact_id as mag_contact_id
             , null as wa_instructor_id
             , o.entity_no as entity_no
             , o.fname as fname
             , o.lname as lname
             , o.email as email
             , 'Not Matched' as join_confidence
             , 'Contact in Magellan Only' as join_description
          FROM o_base o
          LEFT JOIN union_matches um on o.mag_contact_id = um.mag_contact_id
          WHERE um.mag_contact_id is null
)
--, un as (
        SELECT
              un_mag.*
        FROM un_mag
     UNION
          SELECT
               DISTINCT wab.wa_instructor_id AS dim_contact_id
             , null as mag_contact_id
             , wab.wa_instructor_id as wa_instructor_id
             , wab.entity_no as entity_no
             , wab.fname as fname
             , wab.lname as lname
             , wab.email as email
             , 'Not Matched' as join_confidence
             , 'Contact in WebAssign Only' as join_description
          FROM wa_base wab
          LEFT JOIN un_mag on wab.wa_instructor_id = wab.wa_instructor_id
          WHERE un_mag.wa_instructor_id is null
;;
  }
  dimension: dim_contact_id {type: string primary_key: yes}
  dimension: mag_contact_id {type: string}
  dimension: wa_instructor_id {type: string}
  dimension: fname {}
  dimension: lname {}
  dimension: entity_no {}
  dimension: email {}
  dimension: join_confidence {}
  dimension: join_description {}
  dimension: num_records_for_id {}



measure: count {
  label: "Distinct # Contacts"
  description: "Distinct count based on dim_contact_id. dim_contact_id is a concatenated key of Magellan_Contact_iD and WA_Instructor_id when a join was made and either one of those keys when a join was not made"
  type: count
  drill_fields: [contact_info*]
}

measure: count_all {
  label: "Count(*)"
  type: number
  sql: count(*) ;;
}

measure: count_wa_id {
  label: "Distinct Contacts (WA)"
  description: "A distinct count of WA_Instructor_ID"
  type: count_distinct
  sql: ${wa_instructor_id} ;;
  value_format_name: decimal_0
  drill_fields: [contact_info*]
}

measure: count_mag_id {
    label: "Distinct Contacts (Magellan)"
    description: "A distinct count of Mag_Contact_ID"
    type: count_distinct
    sql: ${mag_contact_id} ;;
    value_format_name: decimal_0
    drill_fields: [contact_info*]
    }

measure: num_joined_contacts {
  label: "# Contacts Joined"
  description: "The number of contacts joined across magellan and webassign data"
  type: count_distinct
  sql: case when (${mag_contact_id} is not null AND ${wa_instructor_id} is not null) then ${dim_contact_id}
            end;;
}

####################################### TEMPORARY FOR VALIDATION ###########################################
  dimension: multi_record_name {}
  dimension: contact_id_records {}
  dimension: wa_multi_email_join_test {}
  dimension: fullname1                 {hidden: yes group_label:"Testing Multi Record"}
  dimension: fname1                    {hidden: yes group_label:"Testing Multi Record"}
  dimension: lname1                    {hidden: yes group_label:"Testing Multi Record"}
  dimension: email1                    {hidden: yes group_label:"Testing Multi Record"}
  dimension: fullname2                 {hidden: yes group_label:"Testing Multi Record"}
  dimension: fname2                    {hidden: yes group_label:"Testing Multi Record"}
  dimension: lname2                    {hidden: yes group_label:"Testing Multi Record"}
  dimension: email2                    {hidden: yes group_label:"Testing Multi Record"}
  dimension: rn                        {hidden: yes group_label:"Testing Multi Record" description:"Row number from multi record contacts self joined table (wa_multi_email)"}
  dimension: multi_email_join_desc     {hidden: yes group_label:"Testing Multi Record"}
  dimension: mag_contact_id1           {hidden: yes group_label:"Testing Multi Record"}
  dimension: mag_contact_id2           {hidden: yes group_label:"Testing Multi Record"}

set: contact_info {
  fields: [dim_contact_id, mag_contact_id, wa_instructor_id, entity_no, fname, lname, email, join_confidence, join_description ]
  }

 }
