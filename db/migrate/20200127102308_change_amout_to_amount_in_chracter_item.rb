class ChangeAmoutToAmountInChracterItem < ActiveRecord::Migration[6.0]
  def change
    rename_column :character_items, :amout, :amount
  end
end
