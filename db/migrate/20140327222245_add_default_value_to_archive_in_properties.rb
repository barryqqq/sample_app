class AddDefaultValueToArchiveInProperties < ActiveRecord::Migration
  def change
  end

  def up
  	change_column :properties, :archive, :boolean, default => nil
  end

  def down
  	#change_column :properties, :archive, :boolean, default => true
  end

  

end
