class ChangeDatatypeExpirationDateOfTasks < ActiveRecord::Migration[5.2]
  def up
    change_column :tasks, :expiration_date, :datetime
  end
end
