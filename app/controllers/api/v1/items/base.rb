# frozen_string_literal: true

module API
  module V1
    module Items
      class Base < Root
        namespace :items do
          route_param :id do
            mount Items::Show
          end
        end
      end
    end
  end
end
