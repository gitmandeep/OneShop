class NumberOfUnitsToProducts < ActiveRecord::Migration[5.2]
  def change
  	add_column :products, :number_of_units, :integer
  end
end
