class Lesson < ActiveRecord::Base
    has_one :note
    belongs_to :course
end
