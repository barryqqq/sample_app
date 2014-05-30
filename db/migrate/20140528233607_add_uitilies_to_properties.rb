class AddUitiliesToProperties < ActiveRecord::Migration
  def change
  	add_column :properties, :hasInternet, :boolean
    add_column :properties, :hasElectricity, :boolean
    add_column :properties, :hasHeat, :boolean
  end
end
