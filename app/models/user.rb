class User < ApplicationRecord
  #audited
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include DeviseTokenAuth::Concerns::User

  has_many :enrollments, foreign_key: :student_id, inverse_of: :student
  belongs_to :role

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
    enrollment = self.enrollments.where("batch_id = ?", batch_id).first # to secure that this enrollment and batch belongs to current user
    User.enrollments.where("batch_id = ?", enrollment.batch_id)
  end
 
end
