class Note < ActiveRecord::Base
  belongs_to :course

  belongs_to :lesson
  belongs_to :user
end
