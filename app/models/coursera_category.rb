class CourseraCategory < ActiveRecord::Base
	self.primary_key = 'id'
	has_and_belongs_to_many :coursera_courses, uniq: true
end
