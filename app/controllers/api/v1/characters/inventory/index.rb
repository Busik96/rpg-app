# frozen_string_literal: true

module API
  module V1
    module Characters
      module Inventory
        class Index < Inventory::Base

          before { authorize! }

          desc 'show character inventory with item'
          get do
            inventory_items = CharacterItem.all
            status 200
            ::CharacterItems::DetailedSerializer.new(inventory_items, include: [:item])
          end
        end
      end
    end
  end
end
