class AddImageurlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :imageurl, :text
  end
end
