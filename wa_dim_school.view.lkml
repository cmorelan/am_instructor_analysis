include: "/webassign/dim_school.view.lkml"
include: "/webassign/webassig*.model.lkml"


view: wa_dim_school {
  extends: [dim_school]

##################################################################  IDENTIFIERS #####################################################################

  dimension: dim_school_id         { hidden: no primary_key: yes  label:"     Dim School ID"}
  dimension: school_id             { hidden: yes                   label:"    School ID"}
  dimension: sf_account_id         { hidden: yes }
  dimension: code                  { label: "   School Code" group_label:"   School Info"}

##################################################################### KEY INFO ######################################################################

  dimension: cl_entity_number      { label: "     Entity Number"  group_label:"   School Info"}
  dimension: name                  { label: "     School Name" group_label:"   School Info"}
  dimension: type                  { label: "    School Type" group_label:"   School Info"}
  dimension: price_category_desc   { label: "  School Price Category Description" group_label:"   School Info" description: "Highschool, Quarter, or Semester"  }


#################################################################### CONTACT INFO ###################################################################

  dimension: acct_mgr              { label: "  Account Manager"   group_label: "Cengage Account Reps" }
  dimension: cengage_rep_name      { label: "  Cengage Rep Name"  group_label: "Cengage Account Reps" }
  dimension: cengage_rep_email     { label: " Cengage Rep Email"  group_label: "Cengage Account Reps" }

  dimension: phone                 { hidden: yes }
  dimension: email                 { hidden: yes  }
  dimension: license               { hidden: yes description:"All cells are null values"  }




##################################################################### INSTITUTION LOCATION #########################################################

  dimension: continent_id          { hidden: yes group_label: "Institution Location" }
  dimension: continent_name        { hidden: yes group_label: "Institution Location" }
  dimension: country_abbr          { hidden: yes group_label: "Institution Location"  }
  dimension: country_id            { hidden: yes group_label: "Institution Location"  }
  dimension: country_name          { group_label: "Institution Location"  }
  dimension: city                  { group_label: "Institution Location"  }
  dimension: region_id             { hidden: yes group_label: "Institution Location"  }
  dimension: region_name           { hidden: yes group_label: "Institution Location"  }
  dimension: state_abbr            { group_label: "Institution Location"  }
  dimension: state_id              { hidden: yes group_label: "Institution Location"  }
  dimension: state_name            { group_label: "Institution Location" }
  dimension: territory_id          { hidden: yes group_label: "Institution Location" }
  dimension: territory_name        { hidden: yes group_label: "Institution Location"  }
  dimension: zip                   { group_label: "Institution Location"  }


##################################################################### TIME & DATE #########################################################

  dimension: timezone_id           { hidden: yes group_label: "Time & Date"  }
  dimension: timezone_name         { hidden: no group_label: "Time & Date"  }
  dimension_group: created_eastern { group_label: "Time & Date" }
  dimension_group: date_from       { hidden: yes description:"Useless vast majority of to and from date are from min value '1900' to max value '2199' " }
  dimension_group: date_to         { hidden: yes description:"Useless vast majority of to and from date are from min value '1900' to max value '2199' "}
  dimension: dim_time_id_created   { hidden: yes }



  dimension: password_ruleset      { hidden: yes  }
  dimension: bb_version            { hidden: yes }
  dimension: price_category        { hidden: yes  }
  dimension: use_https             { hidden: yes  }
  dimension: version               { hidden: yes  }


  measure: count {
    label: "# Unique Schools"
    type: count
    drill_fields: [detail*]
  }
}
