# frozen_string_literal: true

module CharacterItems
  class DetailedSerializer
    include FastJsonapi::ObjectSerializer

    set_type :character_item

    attributes :amount

    belongs_to :item, serializer: Items::DetailedSerializer
  end
end
