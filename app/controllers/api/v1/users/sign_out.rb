# frozen_string_literal: true

module API
  module V1
    module Users
      class SignOut < Base
        desc 'Logging out user'

        before { authorize! }

        get :sign_out do
          current_user.update!(api_key: nil)
          status 200
            { status: :ok }
        end
      end
    end
  end
end
