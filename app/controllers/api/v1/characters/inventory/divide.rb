# frozen_string_literal: true

module API
  module V1
    module Characters
      module Inventory
        class Divide < Inventory::Base

          before { authorize! }

          params do
            requires :desired_amount, type: Integer
          end

          desc 'Divide one stack to two'
          post :divide do
            inventory_item = ::Inventory::DivideItem.new.call(
              current_character,
              current_character_item,
              desired_amount = params[:desired_amount]
            )
            inventory_item.error.present? ? status(422) : status(201)

            {
              error: inventory_item.error
            }
          end
        end
      end
    end
  end
end
