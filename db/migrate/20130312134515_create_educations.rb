class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.integer :user_id
      t.string :university
      t.string :faculty_name
      t.date :enrollment_date
      t.date :graduation_date
      t.string :domain
      t.string :specialization

      t.timestamps
    end
  end
end
