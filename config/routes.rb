Rails.application.routes.draw do

  resources :topics do
    resources :bookmarks, except: [:index]
  end

  resources :bookmarks do
    resources :like, only: [:index, :create, :destroy]
  end

  devise_for :users
  resources :users

  post :incoming, to: 'incoming#create'

  get 'about' =>'welcome#about'

  root 'welcome#index'

end
