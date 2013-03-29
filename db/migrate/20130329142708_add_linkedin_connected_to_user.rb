class AddLinkedinConnectedToUser < ActiveRecord::Migration
  def change
    add_column :users, :linkedin_connected, :integer
  end
end
