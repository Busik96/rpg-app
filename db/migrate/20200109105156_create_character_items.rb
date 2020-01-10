# frozen_string_literal: true

class CreateCharacterItems < ActiveRecord::Migration[6.0]
  def change
    create_table :character_items do |t|
      t.integer :amout
      t.references :user
      t.references :item

      t.timestamps
    end
  end
end
