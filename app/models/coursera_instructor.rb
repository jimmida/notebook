class CourseraInstructor < ActiveRecord::Base
    self.primary_key = 'id'
    has_and_belongs_to_many :coursera_courses, uniq: true
    has_and_belongs_to_many :coursera_sessions, uniq: true
    has_and_belongs_to_many :coursera_universities, uniq: true
end
