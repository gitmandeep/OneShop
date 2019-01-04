class CartsProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts_products do |t|
      t.integer :cart_id
      t.integer :product_id
      t.integer :quantity, default: 0
    end
  end
end
