class RemoveFacultyNameFromEducations < ActiveRecord::Migration
  def up
    remove_column :educations, :faculty_name
  end

  def down
    add_column :educations, :faculty_name, :string
  end
end
