class CreateJoinTableCourseraCourseCategory < ActiveRecord::Migration
  def change
    create_join_table :coursera_courses, :coursera_categories, 
    	table_name: :coursera_categories_courses do |t|
      t.index [:coursera_course_id, :coursera_category_id], 
      	unique: true, name: 'coursera_course_category'
      t.index [:coursera_category_id, :coursera_course_id], 
      	unique: true, name: 'coursera_category_course'
    end
  end
end
