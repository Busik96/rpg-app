# frozen_string_literal: true

# == Schema Information
#
# Table name: character_items
#
#  id           :bigint           not null, primary key
#  amount       :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  character_id :bigint           not null
#  item_id      :bigint
#  user_id      :bigint
#
# Indexes
#
#  index_character_items_on_character_id  (character_id)
#  index_character_items_on_item_id       (item_id)
#  index_character_items_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (character_id => characters.id)
#

class CharacterItem < ApplicationRecord
  MAX_ITEM_STACK = 10

  belongs_to :character
  belongs_to :item

  validates :amount, presence: true, numericality: { minimum: 1, maximum: MAX_ITEM_STACK }

  def left_space
    MAX_ITEM_STACK - amount
  end
end
