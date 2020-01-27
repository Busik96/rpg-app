#frozen_string_literal = true

module Inventory
  class DivideItem
    attr_reader :error

    def call(current_character, current_character_item, desired_amount)
      if valid_amount?(current_character_item, desired_amount)
        amount = current_character_item.amount - desired_amount
        current_character_item.update(amount: amount)
        current_character.character_items.create(
          amount: desired_amount,
          item: current_character_item.item
        )
      end


      result
    end

    private

    def valid_amount?(current_character_item, desired_amount)
      if current_character_item.amount == 1
        @error = "You have only 1 item. You can't divided it"
        false
      elsif desired_amount >= current_character_item.amount
        @error = 'Please enter a smaller number'
        false
      else
        true
      end
    end


    def result
      OpenStruct.new(
        error: error || nil
      )
    end
  end
end
