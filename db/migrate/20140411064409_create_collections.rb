class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.integer :user_id
      t.integer :property_id

      t.timestamps
    end
  end
end
