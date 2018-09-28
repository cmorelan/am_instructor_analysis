#connection: "snowflake_dev"

include: "*.view.lkml"
include: "instructor_analysis_base.model.lkml"

# explore: course_instructor  { hidden: yes }
#
# explore: section_instructor { hidden: yes }

# explore: instructor_union {}
