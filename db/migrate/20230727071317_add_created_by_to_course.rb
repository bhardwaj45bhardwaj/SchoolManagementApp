class AddCreatedByToCourse < ActiveRecord::Migration[6.1]
  def change
    add_column :courses, :created_by, :integer
  end
end
