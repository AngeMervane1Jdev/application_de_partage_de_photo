Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?  
  root  to:"users#new"
  get '/post/favorites/list', to: 'feeds#favorites_list' ,as: 'post_favorites_list'
  resources :sessions
  resources :users
  resources :feeds do
    collection do
      post :confirm
    end
  end
  get '/user/favorites/:id', to: 'feeds#make_it_as_my_favorite',as: 'post_favorite'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
