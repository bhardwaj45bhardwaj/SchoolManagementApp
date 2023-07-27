# spec/models/school_spec.rb
require 'rails_helper'

RSpec.describe School, type: :model do
  
  let(:school) {School.create(name: "abc")}
  let(:course) {school.courses.create(name: "Science")}
  
  describe 'associations' do
    it { should have_many(:courses).dependent(:destroy) }
  end

  describe 'validations' do
  
    it 'is valid with valid attributes' do
      expect(school).to be_valid
    end

    it 'is not valid without a name' do
      school.name = nil
      school.save
      expect(subject).to_not be_valid
    end

     it 'is valid with a name' do
      school.name = "new name"
      school.save
      expect(subject).to be_valid
    end

    # it { should validate_presence_of(:name).strict}

    it 'is valid with unique name' do 
      school.name = "xyz"
      should validate_uniqueness_of(:name) 
    end
  end
end
