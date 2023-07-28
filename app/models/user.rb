class User < ApplicationRecord
  #audited
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include DeviseTokenAuth::Concerns::User

  has_many :enrollments, foreign_key: :student_id, inverse_of: :student
  belongs_to :role
  belongs_to :school, optional: true
  
  validate :is_school_available

  def admin?
    role.name == "Admin"
  end

  def school_admin?
    role.name == "SchoolAdmin"
  end

  def student?
    role.name == "Student"
  end

  def get_students_by_batch(batch_id)
    User.joins(:enrollments).where("batch_id = ?", batch_id)
  end

  private

  def is_school_available
    if school && self.admin?
      errors.add(:school, "please remove school for admin")
    elsif school.nil? && (self.school_admin? || self.student?)
      errors.add(:school, "please add school for school admin and student")
    end
  end
 
end
