class CreateUserCards < ActiveRecord::Migration[5.2]
  def change
    create_table :user_cards do |t|
      t.references :user, foreign_key: true
      t.string  :user_card_id
      t.string  :customer_id
      t.integer :card_exp_month
      t.integer :card_exp_year
      t.integer :card_last4
      t.timestamps
    end
  end
end
