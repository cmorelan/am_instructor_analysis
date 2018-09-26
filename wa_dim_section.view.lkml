#include: "/webassign/webassign.model.lkml"
 include: "/webassign/dim_section.view.lkml"
view: wa_dim_section {
  extends: [dim_section]


dimension: course_instructor_email {
  sql: ${TABLE}.course_instructor_email ;;
}

dimension: section_instructor_email {
  sql: ${TABLE}.section_instructor_email ;;
}

}
