class AddCharacterIdToCharacterItem < ActiveRecord::Migration[6.0]
  def change
    add_reference :character_items, :character, null: false, foreign_key: true
  end
end
