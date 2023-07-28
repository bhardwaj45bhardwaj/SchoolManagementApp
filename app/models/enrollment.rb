class Enrollment < ApplicationRecord
  #audited
  belongs_to :student, class_name: 'User', foreign_key: :student_id, inverse_of: :enrollments
  belongs_to :batch

  enum status: {pending: 0, approved: 1, denied: 2}

  validates :student, uniqueness: { scope: :batch } 

  before_validation :set_status, on: :create

  validates :status, presence: true

  def set_status
    self.status = 0
  end
  
  #Display school wise enrollments for school admin
  def self.get_school_enrollments(school_id)
    Enrollment.joins(batch: :course).where("courses.school_id = ?", school_id)
  end
end
