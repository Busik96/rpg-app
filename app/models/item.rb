# frozen_string_literal: true

# == Schema Information
#
# Table name: items
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  reusable    :boolean          default(FALSE)
#  stats       :jsonb
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true, length: { maximum: 250 }
  validates :stats, presence: true
end
