class AddColumnsToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :isPublic, :boolean
    add_column :properties, :ip, :string
    add_column :properties, :hasContract, :boolean
    add_column :properties, :contract, :string
    add_column :properties, :gender, :integer
    add_column :properties, :people, :integer
    add_column :properties, :pet, :integer
    add_column :properties, :count, :integer
    add_column :properties, :start_date, :date
    add_column :properties, :end_date, :date
    
  end
end
