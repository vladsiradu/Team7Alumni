class AddProfileUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ProfileUrl, :string
  end
end
