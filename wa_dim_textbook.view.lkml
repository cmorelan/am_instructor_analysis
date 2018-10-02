include: "/webassign/dim_textbook.view.lkml"
include: "/webassign/dim_discipline.view.lkml"
include: "/webassign/webassig*.model.lkml"

view: wa_dim_textbook {
    extends: [dim_textbook]


  measure: count {  }

#######################################################  IDENTIFIERS #########################################################################################################


  dimension: dim_textbook_id         { hidden: yes  }
  dimension: textbookid              { hidden: yes  }
  dimension: dim_product_family_id   { hidden: yes  }
  dimension: dim_discipline_id       { hidden: yes  }
  dimension: sf_product_id           { hidden: yes  }


####################################################### PRODUCT SPECIFICATIONS ###############################################################################################

#------------------------------------------------------------ DETAILS -------------------------------------------------------------------------------------------------------#
  dimension: code                    { label: "   Webassign Product Code" }
  dimension: reporting_isbn          { group_label: "  Product Info" description:"Often Null"  }
  dimension: name                    { group_label: "  Product Info" label: " Product Title"  }
  dimension: short                   { group_label: "  Product Info" label: " Product Title (Short)"  }
  dimension: author                  { group_label: "  Product Info"  }
  dimension: edition                 { group_label: "  Product Info"  }
  dimension: copyright_publisher     { group_label: "  Product Info" label:"(C) Year - Product" }
  dimension: copyright_wa            { group_label: "  Product Info" label:"(C) Year - WebAssign" description:"Appears to be the webassign product copyright date" }

#------------------------------------------------------------ SPECIFICS ------------------------------------------------------------------------------------------------------#

  dimension: is_original_content     { group_label: "Specifics" }
  dimension: loe                     { group_label: "Specifics" description:"Multi-Term, No, or Yes" }
  dimension: available               { group_label: "Specifics"  }
  dimension: is_publisher_textbook   { group_label:"Publisher" }
  dimension: publisher_code          { group_label:"Publisher" }
  dimension: publisher_id            { group_label:"Publisher"  }
  dimension: publisher_name          { group_label:"Publisher"  }

#------------------------------------------------------------ FEATURES -------------------------------------------------------------------------------------------------------#

  dimension: has_ebook               { group_label: "Product Features" }
  dimension: has_practice_it         { group_label: "Product Features"  }
  dimension: has_psp                 { group_label: "Product Features"  }
  dimension: has_read_it             { group_label: "Product Features"  }
  dimension: has_watch_it            { group_label: "Product Features"  }
  dimension: is_labs                 { group_label: "Product Features"  }



############################################################ UNUSED ###########################################################################################################

  dimension: content_id { description: "Unsure of what this means. No similar named field or table to expand" hidden: yes }
  dimension: permission { hidden: yes }
  dimension: price_category { hidden: yes }
  dimension: price_category_desc { hidden: yes  }
  dimension: version { description: "All are version 1. Useless" hidden:yes   }
  dimension_group: date_from {hidden: yes description:"All From the beginning of time. Useless" }
  dimension_group: date_to { hidden: yes description:"To the end of time. Useless"  }

}
