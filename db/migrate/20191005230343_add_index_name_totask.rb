class AddIndexNameTotask < ActiveRecord::Migration[5.2]
  def change
    add_index :tasks, :name
    add_index  :tasks, :state      
  end
end
