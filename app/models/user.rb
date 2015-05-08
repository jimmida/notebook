class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :notes
  has_many :lessons, through: :notes
  has_many :enrollments
  has_many :courses, through: :enrollments

  def registered? course
    self.courses.include? course
  end
end
