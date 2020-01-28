# frozen_string_literal: true

module API
  module V1
    module Characters
      module Inventory
        class AddItem < Base

          before { authorize! }

          desc 'Add new item into inventory'
          params do
            requires :amount, type: Integer
            requires :item_id, type: Integer
          end
          post :add_item do
            inventory_item = ::Inventory::AddItem.new.call(
              current_character,
              Item.find(params[:item_id]),
              params[:amount]
            )
            inventory_item.error.present? ? status(422) : status(201)

            {
              error: inventory_item.error,
              amount_left: inventory_item.amount_left
            }
          end
        end
      end
    end
  end
end
