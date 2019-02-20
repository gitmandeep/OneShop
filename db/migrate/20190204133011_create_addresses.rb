class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :name
      t.integer :mobile
      t.integer :pincode
      t.text :address
      t.string :city
      t.string :state
      t.string :address_type
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
