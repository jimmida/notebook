class CreateJoinTableCourseraInstructorSession < ActiveRecord::Migration
  def change
    create_join_table :coursera_instructors, :coursera_sessions,
    	table_name: :coursera_instructors_sessions do |t|
      t.index [:coursera_instructor_id, :coursera_session_id],
      	unique: true, name: 'coursera_instructor_session'
      t.index [:coursera_session_id, :coursera_instructor_id],
      	unique: true, name: 'coursera_session_instructor'
    end
  end
end
