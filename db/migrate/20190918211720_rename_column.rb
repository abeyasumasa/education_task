class RenameColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks,:create_at,:created_at
  end
end
