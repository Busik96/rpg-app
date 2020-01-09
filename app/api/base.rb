# frozen_string_literal: true

module Api
  class Base < Grape::API
    format :json
    prefix :api

    get :test do
      { status: :ok }
    end

    add_swagger_documentation
  end
end
