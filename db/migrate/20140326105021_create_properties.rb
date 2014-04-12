class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.integer :user_id

      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :country

      t.string :radio_addr
      
      t.string :b_address1
      t.string :b_address2
      t.string :b_city
      t.string :b_state

      t.string :b_zipcode

      t.string :category
      
      t.integer :bed
      t.integer :bath
      
      t.float :price

      t.boolean :hasBrokerFee
      t.boolean :hasDeposit
      
      t.float :broker_fee

      t.string :deposit
      
      t.string :description
      
      t.string :contact_email
      t.string :contact_phone
      
      t.boolean :archive

      

      t.timestamps
    end
  end
end
