class ChangeSomeColusInProperty < ActiveRecord::Migration
  def change
  	change_column :properties, :price, :decimal, :precision => 7, :scale => 2
  	change_column :properties, :broker_fee, :decimal, :precision => 7, :scale => 2
  	change_column :properties, :description, :text
  end
end
