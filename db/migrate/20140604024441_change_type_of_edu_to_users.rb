class ChangeTypeOfEduToUsers < ActiveRecord::Migration
  def change
  	change_column :users, :education, :string
  end
end
