# frozen_string_literal: true

module API
  module V1
    module Characters
      class Destroy < Characters::Base
        before { authorize! }

        desc 'Deletes characters'
        delete do
          if current_character.destroy!
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
