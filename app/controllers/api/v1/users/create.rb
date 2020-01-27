# frozen_string_literal: true

module API
  module V1
    module Users
      class Create < Base
        desc 'Creates new users'
        params do
          requires :email, type: String
          requires :password, type: String
        end
        post do
          user = User.create!(
            email: params[:email],
            password: params[:password]
          )
          status 201
          ::Users::DetailedSerializer.new(user)
        end
      end
    end
  end
end
