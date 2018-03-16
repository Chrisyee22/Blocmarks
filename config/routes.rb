Rails.application.routes.draw do

  resources :topics do
    resources :bookmarks
  end
  
  devise_for :users
  resources :users


  get 'about' =>'welcome#about'

  root 'welcome#index'

end
