# frozen_string_literal: true

module API
  module V1
    module Characters
      class Create < Base
        before { authorize! }

        desc 'Creates new characters'
        params do
          requires :name, type: String
          requires :description, type: String
        end
        post do
          character = current_user.characters.create!(
            name: params[:name],
            description: params[:description]
          )
          status 201
          ::Characters::DetailedSerializer.new(character)
        end
      end
    end
  end
end
