# frozen_string_literal: true

class CreateCharacters < ActiveRecord::Migration[6.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.text :description
      t.jsonb :stats
      t.references :user

      t.timestamps
    end
  end
end
