require 'rails_helper'

RSpec.describe Batch, type: :model do

  describe 'associations' do
    it { should belong_to(:course) }
    it { should have_many(:enrollments) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
