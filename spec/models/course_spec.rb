require 'rails_helper'


RSpec.describe Course, type: :model do

 

  describe 'associations' do
    it { should belong_to(:school) }
    it { should have_many(:batches).dependent(:destroy) }
  end

  describe 'validations' do
    let!(:school) {School.create(name: "abc")}
    let!(:course) {school.courses.create(name: "Science")}

    it { should validate_presence_of(:name) }

    it 'is valid with unique name' do
      should validate_uniqueness_of(:name).scoped_to(:school_id)
    end
 
  end
end
