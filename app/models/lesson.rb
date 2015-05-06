class Lesson < ActiveRecord::Base
    has_many :users, through: :notes
    belongs_to :course
end
