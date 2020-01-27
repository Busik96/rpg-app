# frozen_string_literal: true

module API
  module V1
    module Users
      class Base < Root
        namespace :users do
          mount Me
          mount Create
          mount SignIn
          mount SignOut
        end
      end
    end
  end
end
