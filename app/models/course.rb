class Course < ApplicationRecord
  #audited
  belongs_to :school
  has_many :batches, dependent: :destroy
  validates :name, presence: true, uniqueness: { scope: :school_id }
end
