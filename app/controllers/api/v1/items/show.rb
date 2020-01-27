# frozen_string_literal: true

module API
  module V1
    module Items
      class Show < Items::Base
        desc 'Shows detailed item info'
        params do
          requires :id, type: Integer
        end
        get do
          ::Items::DetailedSerializer.new(Item.find(params[:id]))
        end
      end
    end
  end
end
