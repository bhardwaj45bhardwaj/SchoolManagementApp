class AddCreatedByToBatch < ActiveRecord::Migration[6.1]
  def change
    add_column :batches, :created_by, :integer
  end
end
