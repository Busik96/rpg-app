class AddInventorSizeToCharacters < ActiveRecord::Migration[6.0]
  def change
    add_column :characters, :inventory_size, :integer, default: 20
  end
end
