class AddLocationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
    add_column :users, :gmaps, :boolean
    add_column :users, :location, :string
  end
end
