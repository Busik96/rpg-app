# frozen_string_literal: true

module API
  module V1
    module Characters
      class Show < Characters::Base
        before { authorize! }

        desc 'Shows detailed character info'
        get do
          status 200
          ::Characters::DetailedSerializer.new(current_character)
        end
      end
    end
  end
end
