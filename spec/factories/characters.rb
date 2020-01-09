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


FactoryBot.define do
  factory :character do
    name { Faker::Company.name }
    description { Faker::Lorem.paragraph }
    inventory_size { 20 }
  end
end


