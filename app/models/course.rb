class Course < ActiveRecord::Base
    has_many :lessons
    has_many :notes
    has_many :enrollments
    has_many :users, through: :enrollments
end
