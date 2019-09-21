class AddUpdatedAtToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :updated_at, :datetime
  end
end
