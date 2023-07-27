class AddCreatedByToEnrollment < ActiveRecord::Migration[6.1]
  def change
    add_column :enrollments, :created_by, :integer
    add_column :enrollments, :approved_by, :integer
  end
end
