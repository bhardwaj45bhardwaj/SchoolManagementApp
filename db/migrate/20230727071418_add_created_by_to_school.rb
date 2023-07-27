class AddCreatedByToSchool < ActiveRecord::Migration[6.1]
  def change
    add_column :schools, :created_by, :integer
  end
end
