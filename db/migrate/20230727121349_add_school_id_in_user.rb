class AddSchoolIdInUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :school_id, :integer
  end
end
