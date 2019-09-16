class ChangeNameColumnTasks < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tasks, :name, false, 0
    change_column_null :tasks, :content, false, 0
  end
end
