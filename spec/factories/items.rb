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

FactoryBot.define do
  factory :item do
    name { Faker::Company.name }
    description { Faker::Lorem.paragraph }
    stats { { id: 'stats' } }
  end
end

