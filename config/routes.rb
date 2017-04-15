Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
   root "admin/dashboard#index"
  
  namespace :api do
    resources :scores, only: [:create]
  end

end
