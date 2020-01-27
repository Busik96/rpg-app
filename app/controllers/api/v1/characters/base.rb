# frozen_string_literal: true

module API
  module V1
    module Characters
      class Base < Root
        namespace :characters do
          mount Create
          mount Index

          route_param :id do
            helpers do
              def current_character
                @current_character ||= current_user.characters.find(params[:id])
              end
            end

            mount Show
            mount Destroy
            mount Inventory::Base
          end
        end
      end
    end
  end
end
