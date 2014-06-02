class AddInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :about, :string
    add_column :users, :birthday, :date
    add_column :users, :education, :integer
    add_column :users, :gender, :integer
    add_column :users, :verified, :boolean
    add_column :users, :last_name, :string
    add_column :users, :first_name, :string
    add_column :users, :location, :string
    add_column :users, :can_post, :boolean, :default => true
    add_column :users, :facebook_id, :string
    add_column :users, :webo_id, :string
    add_column :users, :facebook_link, :string
  end
end
