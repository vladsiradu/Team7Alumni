class FixColumnName < ActiveRecord::Migration
 def change
       rename_column :users, :group, :agroup
 end
end
