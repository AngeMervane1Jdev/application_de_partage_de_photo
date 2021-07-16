Rails.application.routes.draw do
  root  to:"users#new"
  resources :sessions
  resources :users
  resources :feeds do
    collection do
      post :confirm
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
