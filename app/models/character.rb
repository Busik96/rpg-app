# frozen_string_literal: true

# == Schema Information
#
# Table name: characters
#
#  id             :bigint           not null, primary key
#  description    :text
#  inventory_size :integer          default(20)
#  name           :string
#  stats          :jsonb
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint
#
# Indexes
#
#  index_characters_on_user_id  (user_id)
#

class Character < ApplicationRecord
  belongs_to :user
  has_many :character_items
  has_many :items, through: :character_items

  validates :name, presence: true
  validates :inventory_size, presence: true
  validates :description, length: { maximum: 250 }
end
