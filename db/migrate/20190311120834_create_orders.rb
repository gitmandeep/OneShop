class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|

      t.references :user, foreign_key: true
      t.references :carts_product, foreign_key: true 
      t.integer :order_amount
      t.integer :number_of_item
      
      t.timestamps
    end
  end
end
