# frozen_string_literal: true

module API
  module V1
    class Base < Root
      version 'v1', using: :path

      helpers do
        def authorize!
          error!('401 Unauthorized', 401) unless current_user.present?
        end

        def current_user
          return if headers['Authorization'].blank?

          @current_user ||= User.find_by(api_key: headers['Authorization'])
        end
      end

      mount Users::Base
      mount Characters::Base
      mount Items::Base
    end
  end
end
