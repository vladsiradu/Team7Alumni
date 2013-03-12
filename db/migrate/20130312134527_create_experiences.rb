class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.integer :user_id
      t.string :job_title
      t.string :company
      t.date :start_date
      t.date :end_date
      t.string :country
      t.string :city
      t.text :description

      t.timestamps
    end
  end
end
