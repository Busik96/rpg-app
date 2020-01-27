# frozen_string_literal: true

module Users
  class DetailedSerializer
    include FastJsonapi::ObjectSerializer

    set_type :user

    attributes :id, :email

    has_many :characters, serializer: Characters::DetailedSerializer
  end
end
