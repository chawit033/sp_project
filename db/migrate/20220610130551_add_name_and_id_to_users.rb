class AddNameAndIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string 
    add_column :users, :user_id, :string 
  end
end
