# frozen_string_literal: true

module API
  module V1
    module Users
      class SignIn < Base
        desc 'Logging in user'
        params do
          requires :email, type: String
          requires :password, type: String
        end
        post :sign_in do
          user = User.find_for_database_authentication(email: params[:email])
          if user && user.valid_for_authentication? { user.valid_password?(params[:password]) }
            api_key = ::Users::TokenGenerator.new.call(user)
            status 200
            { data: { token: api_key } }
          else
            status 422
            { status: :incorrect_credentials }
          end
        end
      end
    end
  end
end
