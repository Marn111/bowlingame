Rails.application.routes.draw do
  
  namespace :api do
    resources :scores, only: [:create]
  end

end
