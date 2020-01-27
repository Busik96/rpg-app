# frozen_string_literal: true

module CharacterItems
  class DetailedSerializer
    include FastJsonapi::ObjectSerializer

    set_type :character_item

    attributes :amout

    belongs_to :item, serializer: Items::DetailedSerializer
    belongs_to :character, serializer: Characters::DetailedSerializer
  end
end
