class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.date :birthdate
      t.string :email
      t.integer :group
      t.integer :promotion
      t.integer :temporary_profile

      t.timestamps
    end
  end
end
