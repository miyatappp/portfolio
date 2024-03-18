Rails.application.routes.draw do
  
  
  get 'homes/top'
  root to: "homes#top"
  

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"}
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'}
  
  namespace :admin do
  resources :posts, only: [:index, :show, :destroy] do
  collection  do
  get :search
  end
  resources :post_comments, only: [:destroy]
  end
  resources :users, only: [:index, :show, :destroy] do
  member do
   get :search 
  end
  collection  do
  get :search_user
  end
  end
  end
  
 
  scope module: :public do
  resources :users, only: [:index, :update, :edit, :show] do
   member do
   get :bookmarks 
   get :search
   get :follows, :followers
   end
   collection  do
  get :search_user
  end
  resource :relationships, only: [:create, :destroy]
  end
  
  resources :posts, only: [:edit, :index, :new, :show, :create, :destroy, :update ] do
  collection  do
  get :search
  end
  resource :bookmark, only: [:create, :destroy]
  resources :post_comments, only: [:create, :destroy]
  end
  
  end
  


end
