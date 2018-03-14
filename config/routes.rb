Rails.application.routes.draw do
  resources :topics
  devise_for :users
  resources :users


  get 'about' =>'welcome#about'

  root 'welcome#index'

end
