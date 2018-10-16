include: "dim_contact.view.lkml"
include: "wa_fact_registration.view.lkml"
include: "am_opty_raw.view.lkml"
include: "wa_textbook_grtopic.view.lkml"

view: dim_topic {
  derived_table: {
    sql:
  WITH ot as (---- use course description to map topic in magellan where as product is used in webassign. Do not include in final table
          SELECT
                DISTINCT c.dim_contact_id as dim_contact_id
              , c.mag_contact_id as mag_contact_id
              , o.cengage_course_description_ct as cengage_course_description_ct
              , CASE
                       WHEN o.cengage_course_description_ct= 'Abstract Algebra' THEN 'Abstract Algebra'
                       WHEN o.cengage_course_description_ct= 'Advanced Algebra' THEN 'Advanced Math'
                       WHEN o.cengage_course_description_ct= 'Advanced Calculus' THEN 'Advanced Math'
                       WHEN o.cengage_course_description_ct= 'Applied Calculus/Business Calculus' THEN 'Applied & Finite Math'
                       WHEN o.cengage_course_description_ct= 'Finite Math with Calculus' THEN 'Applied & Finite Math'
                       WHEN o.cengage_course_description_ct= 'Finite Mathematics' THEN 'Applied & Finite Math'
                       WHEN o.cengage_course_description_ct= 'Calculus - (3 semester)' THEN 'Calculus'
                       WHEN o.cengage_course_description_ct= 'Calculus - (Multivariable)' THEN 'Calculus'
                       WHEN o.cengage_course_description_ct= 'Calculus - Early Transcendentals (3 semester)' THEN 'Calculus'
                       WHEN o.cengage_course_description_ct= 'Calculus - Early Transcendentals (Single Variable)' THEN 'Calculus'
                       WHEN o.cengage_course_description_ct= 'Calculus - Early Vectors (3 semester)' THEN 'Calculus'
                       WHEN o.cengage_course_description_ct= 'Calculus - Single Variable' THEN 'Calculus'
                       WHEN o.cengage_course_description_ct= 'Calculus for Biological Sciences' THEN 'Calculus'
                       WHEN o.cengage_course_description_ct= 'Combinatorics' THEN 'Combinatorics'
                       WHEN o.cengage_course_description_ct= 'Complex Analysis' THEN 'Complex Analysis'
                       WHEN o.cengage_course_description_ct= 'Algebra for College Students (Intermediate & 3 chp' THEN 'Dev Math'
                       WHEN o.cengage_course_description_ct= 'Beg & Intermed Alg Combo' THEN 'Dev Math'
                       WHEN o.cengage_course_description_ct= 'Beginning Algebra' THEN 'Dev Math'
                       WHEN o.cengage_course_description_ct= 'Devel Math (Arith/Alg Combo)' THEN 'Dev Math'
                       WHEN o.cengage_course_description_ct= 'Intermediate Algebra' THEN 'Dev Math'
                       WHEN o.cengage_course_description_ct= 'Prealgebra' THEN 'Dev Math'
                       WHEN o.cengage_course_description_ct= 'Boundary Value Problems/Partial Differential Equat' THEN 'Differential Equations'
                       WHEN o.cengage_course_description_ct= 'DE w/Fourier Anal/Part DE & DE' THEN 'Differential Equations'
                       WHEN o.cengage_course_description_ct= 'Differential Equations' THEN 'Differential Equations'
                       WHEN o.cengage_course_description_ct= 'Differential Equations w/Boundary Value Problems' THEN 'Differential Equations'
                       WHEN o.cengage_course_description_ct= 'Linear Algebra & Differential Equations' THEN 'Differential Equations'
                       WHEN o.cengage_course_description_ct= 'Ordinary Differential Equations' THEN 'Differential Equations'
                       WHEN o.cengage_course_description_ct= 'Partial Differential Equations' THEN 'Differential Equations'
                       WHEN o.cengage_course_description_ct= 'Discrete Math' THEN 'Discrete Math'
                       WHEN o.cengage_course_description_ct= 'Fourier Analysis' THEN 'Fourier Analysis'
                       WHEN o.cengage_course_description_ct= 'Graph Theory' THEN 'Graph Theory'
                       WHEN o.cengage_course_description_ct= 'History of Math' THEN 'History of Math'
                       WHEN o.cengage_course_description_ct= 'General Introductory Statistics' THEN 'Intro Stats'
                       WHEN o.cengage_course_description_ct= 'PreStatistics' THEN 'Intro Stats'
                       WHEN o.cengage_course_description_ct= 'Liberal Arts Math (Algebra based)' THEN 'Liberal Arts Math'
                       WHEN o.cengage_course_description_ct= 'Applied Linear Algebra' THEN 'Linear Algebra'
                       WHEN o.cengage_course_description_ct= 'Linear Algebra' THEN 'Linear Algebra'
                       WHEN o.cengage_course_description_ct= 'Number Theory' THEN 'Number Theory'
                       WHEN o.cengage_course_description_ct= 'Algebra & Trigonometry' THEN 'Precalculus/trig'
                       WHEN o.cengage_course_description_ct= 'College Algebra' THEN 'Precalculus/trig'
                       WHEN o.cengage_course_description_ct= 'Precalculus' THEN 'Precalculus/trig'
                       WHEN o.cengage_course_description_ct= 'Trigonometry' THEN 'Precalculus/trig'
                       WHEN o.cengage_course_description_ct= 'Topology' THEN 'Topology'
                       WHEN o.cengage_course_description_ct= 'Transitional Advanced Math/Introduction to Advance' THEN 'Transition to Advanced Math'
                       WHEN o.cengage_course_description_ct= 'Numerical Analysis/Methods' THEN 'Numerical Analysis'
                       ELSE 'Other'
              END AS topic_bucket
             ,  CASE
                      WHEN o.cengage_course_description_ct= 'Abstract Algebra' THEN 'Advanced'
                      WHEN o.cengage_course_description_ct= 'Advanced Algebra' THEN 'Advanced'
                      WHEN o.cengage_course_description_ct= 'Advanced Calculus' THEN 'Advanced'
                      WHEN o.cengage_course_description_ct= 'Applied Calculus/Business Calculus' THEN 'Lower Level'
                      WHEN o.cengage_course_description_ct= 'Finite Math with Calculus' THEN 'Lower Level'
                      WHEN o.cengage_course_description_ct= 'Finite Mathematics' THEN 'Lower Level'
                      WHEN o.cengage_course_description_ct= 'Calculus - (3 semester)' THEN 'Lower Level'
                      WHEN o.cengage_course_description_ct= 'Calculus - (Multivariable)' THEN 'Lower Level'
                      WHEN o.cengage_course_description_ct= 'Calculus - Early Transcendentals (3 semester)' THEN 'Lower Level'
                      WHEN o.cengage_course_description_ct= 'Calculus - Early Transcendentals (Single Variable)' THEN 'Lower Level'
                      WHEN o.cengage_course_description_ct= 'Calculus - Early Vectors (3 semester)' THEN 'Lower Level'
                      WHEN o.cengage_course_description_ct= 'Calculus - Single Variable' THEN 'Lower Level'
                      WHEN o.cengage_course_description_ct= 'Calculus for Biological Sciences' THEN 'Lower Level'
                      WHEN o.cengage_course_description_ct= 'Combinatorics' THEN 'Advanced'
                      WHEN o.cengage_course_description_ct= 'Complex Analysis' THEN 'Advanced'
                      WHEN o.cengage_course_description_ct= 'Algebra for College Students (Intermediate & 3 chp' THEN 'Lower Level'
                      WHEN o.cengage_course_description_ct= 'Beg & Intermed Alg Combo' THEN 'Lower Level'
                      WHEN o.cengage_course_description_ct= 'Beginning Algebra' THEN 'Lower Level'
                      WHEN o.cengage_course_description_ct= 'Devel Math (Arith/Alg Combo)' THEN 'Lower Level'
                      WHEN o.cengage_course_description_ct= 'Intermediate Algebra' THEN 'Lower Level'
                      WHEN o.cengage_course_description_ct= 'Prealgebra' THEN 'Lower Level'
                      WHEN o.cengage_course_description_ct= 'Boundary Value Problems/Partial Differential Equat' THEN 'Advanced'
                      WHEN o.cengage_course_description_ct= 'DE w/Fourier Anal/Part DE & DE' THEN 'Advanced'
                      WHEN o.cengage_course_description_ct= 'Differential Equations' THEN 'Advanced'
                      WHEN o.cengage_course_description_ct= 'Differential Equations w/Boundary Value Problems' THEN 'Advanced'
                      WHEN o.cengage_course_description_ct= 'Linear Algebra & Differential Equations' THEN 'Advanced'
                      WHEN o.cengage_course_description_ct= 'Ordinary Differential Equations' THEN 'Advanced'
                      WHEN o.cengage_course_description_ct= 'Partial Differential Equations' THEN 'Advanced'
                      WHEN o.cengage_course_description_ct= 'Discrete Math' THEN 'Advanced'
                      WHEN o.cengage_course_description_ct= 'Fourier Analysis' THEN 'Advanced'
                      WHEN o.cengage_course_description_ct= 'Graph Theory' THEN 'Advanced'
                      WHEN o.cengage_course_description_ct= 'History of Math' THEN 'Advanced'
                      WHEN o.cengage_course_description_ct= 'General Introductory Statistics' THEN 'Lower Level'
                      WHEN o.cengage_course_description_ct= 'PreStatistics' THEN 'Lower Level'
                      WHEN o.cengage_course_description_ct= 'Liberal Arts Math (Algebra based)' THEN 'Lower Level'
                      WHEN o.cengage_course_description_ct= 'Applied Linear Algebra' THEN 'Advanced'
                      WHEN o.cengage_course_description_ct= 'Linear Algebra' THEN 'Advanced'
                      WHEN o.cengage_course_description_ct= 'Number Theory' THEN 'Advanced'
                      WHEN o.cengage_course_description_ct= 'Algebra & Trigonometry' THEN 'Lower Level'
                      WHEN o.cengage_course_description_ct= 'College Algebra' THEN 'Lower Level'
                      WHEN o.cengage_course_description_ct= 'Precalculus' THEN 'Lower Level'
                      WHEN o.cengage_course_description_ct= 'Trigonometry' THEN 'Lower Level'
                      WHEN o.cengage_course_description_ct= 'Topology' THEN 'Advanced'
                      WHEN o.cengage_course_description_ct= 'Transitional Advanced Math/Introduction to Advance' THEN 'Lower Level'
                      WHEN o.cengage_course_description_ct= 'Numerical Analysis/Methods' THEN 'Advanced'
                      ELSE 'Other'
              END AS topic_lvl
          FROM ${dim_contact.SQL_TABLE_NAME} as c
          LEFT JOIN DEV.ZCM.AM_OPTY_RAW as o on c.mag_contact_id=o.magellan_contact_id
          WHERE c.mag_contact_id is not null
       )
  , wdst as (-- use product code to map topic in webassign rather than course description like in magellan. hide from final table
          SELECT
                DISTINCT c.dim_contact_id as dim_contact_id
              , c.wa_instructor_id as wa_instructor_id
              , t.code as wa_product_code
              , tgt.grouped_topic as topic_bucket
              , tgt.topic_lvl as topic_lvl
          FROM ${dim_contact.SQL_TABLE_NAME} as c
          LEFT JOIN ${wa_dim_section.SQL_TABLE_NAME} as s on c.wa_instructor_id = s.instructor_id
          LEFT JOIN WEBASSIGN.FT_OLAP_REGISTRATION_REPORTS.dim_textbook as t on s.dim_textbook_id = t.dim_textbook_id
          LEFT JOIN DEV.ZCM.WA_TEXTBOOK_GRTOPIC as tgt on t.code = tgt.wa_prod_code
          WHERE c.wa_instructor_id is not null
  )
--  , uni as (
      SELECT
          DISTINCT dim_contact_id
          , topic_bucket
          , topic_lvl
      FROM ot
  UNION
      SELECT
          DISTINCT dim_contact_id
          , topic_bucket
          , topic_lvl
      FROM wdst
--   )
--       SELECT
--           uni.
--             DISTINCT coalesce(ot.dim_contact_id,wdst.dim_contact_id) as dim_contact_id
--           , ot.mag_contact_id as mag_contact_id
--           , wdst.wa_instructor_id as wa_instructor_id
--           , coalesce(ot.topic_bucket,wdst.topic_bucket) as topic_bucket
--           , coalesce(ot.topic_lvl, wdst.topic_lvl) as topic_lvl
--       FROM ot
--       FULL OUTER JOIN wdst on
--                     ot.
          ;;
  }








dimension: dim_contact_id {}
# dimension: mag_contact_id {}
# dimension: cengage_course_code {}
# dimension: cengage_course_desc {}
# dimension: estimated_enrollment {}






dimension: topic_bucket {
  type: string
  label: "Course Topic Buckets"
  description: "Magellan Course Description is too granular, this buckets the course-based topics into fewer buckets"}


dimension: topic_lvl {
  type: string
  description: "Advanced Math vs Lower-Level"
}
measure: count_courses {
  type: count_distinct
  sql: ${topic_bucket} ;;
}

}
