# frozen_string_literal: true

module API
  module V1
    module Characters
      module Inventory
        class Base < Root
          namespace :inventory do
            mount Index
            mount AddItem

            route_param :character_item_id do
              helpers do
                def current_character_item
                  @current_character_item ||=
                    current_character.character_items.find(
                      params[:character_item_id]
                    )
                end
              end
              mount UseItem
              mount Divide
              mount Destroy
            end
          end
        end
      end
    end
  end
end
