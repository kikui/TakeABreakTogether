Rails.application.routes.draw do
  mount Que::Web => "/que"
  
  resources :users, only: [:new, :create, :show, :update]
  resource :sessions, only: [:new, :create, :destroy]
  resources :groups, only: [:create, :edit, :update, :index, :new]
  resources :user_groups, only: [:create, :destroy]
  resources :histories, only: [:index]
  resources :surveys, only: [:new, :create, :edit, :update, :index, :show]
  resources :proposals, only: [:create, :update]
  resources :votes, only: [:create, :destroy]
  get "signup", to: "users#new", as: "signup"
  get "login", to: "sessions#new", as: "login"
  get "logout", to: "sessions#destroy", as: "logout"
  get '/', to: redirect('/surveys')
  get '*path', to: redirect('/')
end
