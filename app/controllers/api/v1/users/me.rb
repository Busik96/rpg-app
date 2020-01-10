# frozen_string_literal: true

module API
  module V1
    module Users
      class Me < Base
        desc 'Returns current user details'

        before { authorize! }

        get :me do
          ::Users::DetailedSerializer.new(current_user)
        end
      end
    end
  end
end
