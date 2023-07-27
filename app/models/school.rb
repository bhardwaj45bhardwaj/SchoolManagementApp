class School < ApplicationRecord
	#audited
	has_many :courses, dependent: :destroy
	
	validates_uniqueness_of :name
end
