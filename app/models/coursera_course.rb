class CourseraCourse < ActiveRecord::Base
    self.primary_key = 'id'
    has_many :coursera_sessions, foreign_key: "courseId"
    has_and_belongs_to_many :coursera_categories, uniq: true
    has_and_belongs_to_many :coursera_instructors, uniq: true
    has_and_belongs_to_many :coursera_universities, uniq: true
end
