# frozen_string_literal: true

module API
  module V1
    module Characters
      class Index < Characters::Base

        before { authorize! }

        desc 'Deletes characters'
        get do
          characters = Character.all
          status 200
          ::Characters::SimplySerializer.new(characters)
        end
      end
    end
  end
end
