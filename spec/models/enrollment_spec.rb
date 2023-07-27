require 'rails_helper'

RSpec.describe Enrollment, type: :model do

  describe 'associations' do
    it { should belong_to(:student) }
    it { should belong_to(:batch) }
  end

  describe 'validations' do
    it { should validate_presence_of(:status) }
    it { should define_enum_for(:status).with_values([:pending, :approved, :denied]) }
  end
end
