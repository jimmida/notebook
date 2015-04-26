class CourseraSession < ActiveRecord::Base
    self.primary_key = 'id'
    belongs_to :coursera_course, foreign_key: "courseId"
    has_and_belongs_to_many :coursera_instructors, uniq: true
end
