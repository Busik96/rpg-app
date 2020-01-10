# frozen_string_literal: true

module Items
  class DetailedSerializer
    include FastJsonapi::ObjectSerializer

    set_type :item

    attributes :name, :description, :stats
  end
end
