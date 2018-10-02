include: "/webassign/dim_section.view.lkml"
include: "/webassign/webassig*.model.lkml"

view: wa_dim_section {
  extends: [dim_section]


#   dimension: dim_section_id     {primary_key: yes  }




#########################################################################################################################################
################################################# INSTRUCTOR FIELDS #####################################################################
#########################################################################################################################################


#------------------------------------------------ Course Instructor --------------------------------------------------------------------#

  dimension: course_instructor_id {view_label:"Instructor" }
  dimension: course_instructor_name {view_label: "Instructor"}
  dimension: course_instructor_email {view_label: "Instructor"  }
  dimension: course_instructor_sf_id {view_label: "Instructor"  }
  dimension: course_instructor_username {view_label: "Instructor"  }

  measure: course_instructor_count {view_label: "Instructor" group_label:"Course Instructor Details"}




#------------------------------------------------- Section Instructor -------------------------------------------------------------------#

  dimension: section_instructor_id { view_label: "Instructor" }
  dimension: section_instructor_name { view_label: "Instructor" }
  dimension: section_instructor_username { view_label: "Instructor" }
  dimension: section_instructor_sf_id {view_label: "Instructor"     }
  dimension: section_instructor_email {view_label: "Instructor"  }

  measure: sect_instructor_count{view_label: "Instructor" group_label:"Section Instructor Details"}




################################################## SECTION FIELDS ######################################################################


#---------------------------------------------------- Course --------------------------------------------------------------------------#


  dimension: course_id          { group_label: " Course Level"  }
  dimension: course_name        { group_label: " Course Level" }
  dimension: course_description { group_label: " Course Level" }


#---------------------------------------------------- Section -------------------------------------------------------------------------#

  dimension: section_id         { group_label: " Section Level"  }
  dimension: class_key          { group_label: " Section Level" }
  dimension: section_name       { group_label: " Section Level" }
  dimension: meets              {  }
  dimension: trashed            {  }

  dimension: registrations      { group_label: " Section Totals" }
  dimension: deployments        { group_label: " Section Totals" }
  dimension: roster             { group_label: " Section Totals"   }

  measure: roster_sum           { group_label: " Section Level" }
  measure: count                { group_label: " Section Level" }


#--------------------------------------------------- Gradebook ------------------------------------------------------------------------#

  dimension: gb_configured      {  }
  dimension: gb_has_data        {  }


#----------------------------------------------- Enabled Features ---------------------------------------------------------------------#


  dimension: psp_enabled                  { hidden: yes }
  dimension: psp_mode                     { hidden: yes }
  dimension: psp_students_attempting_test { hidden: yes }
  dimension: granted_ebook                { hidden: yes }




  dimension: recency_date                 {  }







#------------------------------------------------- DATE FIELDS  ------------------------------------------------------------------------#

#-------------- Semester ----------------------#

  dimension: term             { hidden: yes  }  ### Useless
  dimension: term_description { hidden: yes }  #### Useless

  dimension: cdate                { group_label: "Date - Start, End, Created" }
  dimension: year                 { group_label: "Date - Start, End, Created"  }
  dimension: created_eastern      { group_label: "Date - Start, End, Created"   }
  dimension: dim_time_id_created  { hidden: yes  }
  dimension: dim_time_id_leeway   { hidden: yes  }
  dimension: leeway_eastern       { hidden: yes  }
  dimension: date_from            { hidden: yes  }
  dimension: dim_time_id_ends     { hidden: yes  }
  dimension: date_to              { hidden: yes  }
  dimension: ends_eastern_raw     { group_label: "Date - Start, End, Created"   }
  dimension: ends_eastern         { group_label: "Date - Start, End, Created"  }
  dimension: dim_time_id_starts   { hidden: yes  }
  dimension: starts_eastern       { group_label: "Date - Start, End, Created"   }
  dimension: start_date_raw       { group_label: "Date - Start, End, Created"   }






################################################# TEXTBOOK FIELDS ########################################################################

  dimension: dim_textbook_id      { hidden: yes }
  dimension: using_open_resources {  }

################################################## SCHOOL FIELDS #########################################################################

  dimension: school_id      { hidden: yes  }

  measure: school_count     { hidden: yes }


################################################# DISCIPLINE FIELDS ######################################################################

  dimension: dim_discipline_id { hidden:yes }




################################################# ADDED BY ME #############################################################################

  dimension: cdate_year {
    type: number
    label: "Created Year"
    group_label: "Date - Start, End, Created"
    sql: left(${TABLE}.cdate,4) ;;
  }

  measure: max_cdate {
    label: "Last Section Created Date"
    group_label: "First/Last Created Dates"
    sql: MAX(${TABLE}.cdate) ;;
  }

  measure: max_cdate_year {
    label: "Last Section Created Year"
    group_label: "First/Last Created Dates"
    sql: LEFT(MAX(${TABLE}.cdate),4) ;;
  }

  measure: min_cdate {
    label: "First Section Created Date"
    group_label: "First/Last Created Dates"
    sql: MIN(${TABLE}.cdate) ;;
  }

  measure: min_cdate_year {
    label: "First Section Created Year"
    group_label: "First/Last Created Dates"
    sql: LEFT(MIN(${TABLE}.cdate),4) ;;
  }

  measure: num_years_wsections {
    label: "# Years w/ Sections"
    description: "Difference between first section created year and last sections created year"
    group_label: "First/Last Created Dates"
    sql:
          round(
                LEFT(MAX(${TABLE}.cdate),4)-LEFT(MIN(${TABLE}.cdate),4)+1
                ) ;;
    value_format: "0"
  }

############################################### UNUSED FIELDS #############################################################################

  dimension: bill_institution_option              {hidden: yes  }
  dimension: bill_institution_po_num              {hidden: yes  }
  dimension: bill_institution_contact_phone       {hidden: yes  }
  dimension: bill_institution_invoice_number      {hidden: yes  }
  dimension: bill_institution_contact_email       {hidden: yes  }
  dimension: bill_institution_invoice_amount      {hidden: yes  }
  dimension: bill_institution_invoice_date        {hidden: yes  }
  dimension: billing                              {hidden: yes  }
  dimension: bill_institution_method              {hidden: yes  }
  dimension: bill_institution_comments            {hidden: yes  }
  dimension: bill_institution_contact_name        {hidden: yes  }
  dimension: bill_institution_isbn                {hidden: yes  }
  dimension: has_invoice                          {hidden: yes  }
  dimension: _fivetran_deleted                    {hidden: yes  }
  dimension: bb_version                           {hidden: yes  }
  dimension: _fivetran_synced                     {hidden: yes  }
  dimension: psp_students_attempting_quiz         {hidden: yes  }
  dimension: version                              {hidden: yes  }



  }
