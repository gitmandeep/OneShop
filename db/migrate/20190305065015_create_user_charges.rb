class CreateUserCharges < ActiveRecord::Migration[5.2]
  def change
    create_table :user_charges do |t|
      t.references :user, foreign_key: true
      t.string  :stripe_charge_id
      t.integer :amount
      t.text    :description
      
      t.timestamps
    end
  end
end
