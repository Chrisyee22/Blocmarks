Rails.application.routes.draw do

  get 'incoming/create'

  resources :topics do
    resources :bookmarks
  end

  devise_for :users
  resources :users

  post :incoming, to: 'incoming#create'
  
  get 'about' =>'welcome#about'

  root 'welcome#index'

end
