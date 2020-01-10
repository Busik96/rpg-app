# frozen_string_literal: true

module Characters
  class SimplySerializer
    include FastJsonapi::ObjectSerializer

    set_type :character

    attributes :name, :description
  end
end
