class ChangeNotnullToTasks < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tasks, :expiration_date, false, Time.now
  end
end
