class AddcreatedAtToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks , :create_at, :datetime
  end
end
