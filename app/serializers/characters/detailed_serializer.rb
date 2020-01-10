# frozen_string_literal: true

module Characters
  class DetailedSerializer
    include FastJsonapi::ObjectSerializer

    set_type :character

    attributes :name, :description, :inventory_size, :stats

    belongs_to :user, serializer: Users::DetailedSerializer
    has_many :character_items, serializer: CharacterItems::DetailedSerializer
    has_many :items, serializer: Items::DetailedSerializer
  end
end
