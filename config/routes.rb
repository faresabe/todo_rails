Rails.application.routes.draw do
root "tasks#index"

get 'signup' , to: 'user#new' ,as: 'signup'
get 'login', to: 'sessions#new', as: 'login'
post 'login', to: 'sessions#create'
delete 'logout', to: 'sessions#destroy', as: 'logout'


resources :users, only: [:new, :create]
  resources :tasks
 
end
