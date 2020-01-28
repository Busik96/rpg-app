# frozen_string_literal: true

ActiveAdmin.register Item do
  permit_params :name, :description, :stats

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :stats
    column :reusable
    actions
  end

  filter :name
  filter :description
  filter :stats
  filter :reusable

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :stats, as: :jsonb
      f.input :reusable, as: :boolean
    end
    f.actions
  end
end
