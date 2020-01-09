# frozen_string_literal: true

class CharacterItem < ApplicationRecord
  belongs_to :character
  belongs_to :item
end
