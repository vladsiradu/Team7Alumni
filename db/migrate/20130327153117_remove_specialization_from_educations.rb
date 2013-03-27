class RemoveSpecializationFromEducations < ActiveRecord::Migration
  def up
    remove_column :educations, :specialization
  end

  def down
    add_column :educations, :specialization, :string
  end
end
