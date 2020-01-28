#frozen_string_literal = true

module Inventory
  class UseItem
    def call(current_character, current_character_item)
      item = current_character_item.item
      return if item.reusable?

      if current_character_item.amount > 1
        current_character_item.amount -= 1
        current_character_item.save
      else
        current_character_item.destroy
      end
    end
  end
end
