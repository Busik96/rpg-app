# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  mount API::Root => '/'
  mount GrapeSwaggerRails::Engine => '/swagger'
end
