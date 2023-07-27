class Enrollment < ApplicationRecord
  #audited
  belongs_to :student, class_name: 'User', foreign_key: :student_id, inverse_of: :enrollments
  belongs_to :batch

  enum status: {pending: 0, approved: 1, denied: 2}

  validates :student, uniqueness: { scope: :batch } 

  validates :status, presence: true

  before_create :set_status

  def set_status
    status = :pending
  end
end
