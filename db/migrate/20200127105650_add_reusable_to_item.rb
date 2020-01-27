class AddReusableToItem < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :reusable, :boolean, default: false
  end
end
