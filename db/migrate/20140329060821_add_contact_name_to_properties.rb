class AddContactNameToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :contact_name, :string
  end
end
