class ModifyColsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :language, :string
    add_column :users, :phone, :string
    add_column :users, :work, :string
    add_column :users, :is_public, :boolean

  end

  def self.down
    # rename back if you need or do something else or do nothing
    remove_column :users, :language, :string
    remove_column :users, :phone, :string
    remove_column :users, :work, :string
    remove_column :users, :is_public, :boolean
  end
end
