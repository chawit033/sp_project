class AddNameAndIdToInstructor < ActiveRecord::Migration[7.0]
  def change
    add_column :instructors, :name, :string 
    add_column :instructors, :teacher_id, :string 
  end
end
