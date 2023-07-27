class RemoveStudentFromEnrollments < ActiveRecord::Migration[6.1]
  def change
    remove_reference :enrollments, :student, null: false, foreign_key: true
  end
end
