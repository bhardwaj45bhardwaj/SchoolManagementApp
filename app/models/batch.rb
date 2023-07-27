class Batch < ApplicationRecord
  #audited
  belongs_to :course
  has_many :enrollments
  validates :name, presence: true, uniqueness: { scope: :course_id, case_sensitive: false }
end
