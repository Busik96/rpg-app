# frozen_string_literal: true

module Inventory
  class AddItem
    attr_reader :item, :error, :amount_left

    def call(current_character, item, amount)
      while amount > 0
        existing_stack = find_existing_stack(current_character, item)
        if existing_stack.present?
          amount = fill_existing_stack(amount, existing_stack)
        else
          break if inventory_full?(current_character)

          amount = create_new_stack(amount, current_character, item)
        end
      end

      if amount > 0
        @error = 'Inventory is full!'
        @amount_left = amount
      end

      result
    end

    private

    def find_existing_stack(current_character, item)
      current_character
        .character_items
        .where('item_id = ? AND amount < ?', item.id, CharacterItem::MAX_ITEM_STACK)
        .first
    end

    def inventory_full?(current_character)
      current_character.character_items.count >= current_character.inventory_size
    end

    def fill_existing_stack(amount, existing_stack)
      if amount - existing_stack.left_space >= 0
        left_amount = amount - existing_stack.left_space
        existing_stack.update(amount: CharacterItem::MAX_ITEM_STACK)
      else
        existing_stack.update(amount: existing_stack.amount + amount)
        left_amount = 0
      end

      left_amount
    end

    def create_new_stack(amount, current_character, item)
      if amount >= CharacterItem::MAX_ITEM_STACK
        left_amount = amount - CharacterItem::MAX_ITEM_STACK
        current_character.character_items.create(
          item: item,
          amount: CharacterItem::MAX_ITEM_STACK
        )
      else
        current_character.character_items.create(item: item, amount: amount)
        left_amount = 0
      end

      left_amount
    end

    def result
      OpenStruct.new(
        error: error || nil,
        amount_left: amount_left || 0
      )
    end
  end
end
