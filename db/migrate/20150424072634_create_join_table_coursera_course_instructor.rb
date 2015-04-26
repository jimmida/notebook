class CreateJoinTableCourseraCourseInstructor < ActiveRecord::Migration
  def change
    create_join_table :coursera_courses, :coursera_instructors, 
    	table_name: :coursera_courses_instructors do |t|
      t.index [:coursera_course_id, :coursera_instructor_id],
      	unique: true, name: 'coursera_course_instructor'
      t.index [:coursera_instructor_id, :coursera_course_id],
      	unique: true, name: 'coursera_instructor_course'
    end
  end
end
