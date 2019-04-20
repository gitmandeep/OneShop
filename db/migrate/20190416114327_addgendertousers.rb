class Addgendertousers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_female, :boolean, default: false  
  end
end
