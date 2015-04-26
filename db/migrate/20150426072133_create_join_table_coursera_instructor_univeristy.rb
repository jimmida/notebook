class CreateJoinTableCourseraInstructorUniveristy < ActiveRecord::Migration
  def change
    create_join_table :coursera_instructors, :coursera_universities,
    	table_name: :coursera_instructors_universities do |t|
      t.index [:coursera_instructor_id, :coursera_university_id],
      	unique: true, name: 'coursera_instructor_university'
      t.index [:coursera_university_id, :coursera_instructor_id],
      	unique: true, name: 'coursera_university_instructor'
    end
  end
end
