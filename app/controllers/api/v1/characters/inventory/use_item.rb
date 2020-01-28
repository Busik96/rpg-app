# frozen_string_literal: true

module API
  module V1
    module Characters
      module Inventory
        class UseItem < Inventory::Base

          before { authorize! }

          desc 'use the item or use the item and remove it'
          post :use_item do
            ::Inventory::UseItem.new.call(
              current_character,
              current_character_item
            )
            status 201
            ::Items::DetailedSerializer.new(current_character_item.item)
          end
        end
      end
    end
  end
end
