class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :your_comment
      t.string :comment_by
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
