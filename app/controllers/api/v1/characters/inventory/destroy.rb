# frozen_string_literal: true

module API
  module V1
    module Characters
      module Inventory
        class Destroy < Inventory::Base

          before { authorize! }

          desc 'Deletes character item'
          delete do
            if current_character_item.destroy!
              status 200
              { status: :ok }
            else
              { status: :error }
            end
          end
        end
      end
    end
  end
end
