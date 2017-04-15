Rails.application.routes.draw do
  root 'welcome#index'
  
  namespace :api do
    resources :scores, only: [:create]
  end

end
