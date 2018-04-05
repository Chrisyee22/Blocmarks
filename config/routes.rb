Rails.application.routes.draw do

  get 'users/show'

  resources :topics do
    resources :bookmarks, except: [:index]
  end

  resources :bookmarks do
    resources :likes, only: [:index, :create, :destroy]
  end

  devise_for :users
  resources :users, only: [:show]

  post :incoming, to: 'incoming#create'

  get 'about' =>'welcome#about'

  root 'welcome#index'

end
