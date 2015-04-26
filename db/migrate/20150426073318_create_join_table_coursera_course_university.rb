class CreateJoinTableCourseraCourseUniversity < ActiveRecord::Migration
  def change
    create_join_table :coursera_courses, :coursera_universities,
    	table_name: :coursera_courses_universities do |t|
      t.index [:coursera_course_id, :coursera_university_id],
      	unique: true, name: "coursera_course_university"
      t.index [:coursera_university_id, :coursera_course_id],
      	unique: true, name: "coursera_university_course"
    end
  end
end
