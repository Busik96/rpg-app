# frozen_string_literal: true

module API
  class Root < Grape::API
    format :json
    prefix :api

    mount ::API::V1::Base

    add_swagger_documentation
  end
end
