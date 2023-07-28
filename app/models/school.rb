class School < ApplicationRecord
	#audited
	has_many :courses, dependent: :destroy
	
	validates_uniqueness_of :name

	has_many :school_admins, foreign_key: :user_id, inverse_of: :user

end
