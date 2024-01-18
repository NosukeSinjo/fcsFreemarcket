Rails.application.routes.draw do

  get 'merchantlogin', to: 'merchantsessions#new'
  post 'merchantlogin', to: 'merchantsessions#create'
  delete 'logout', to: 'merchantsessions#destroy'

  get 'userlogin', to: 'usersessions#new'
  post 'userlogin', to: 'usersessions#create'
  delete 'logout', to: 'usersessions#destroy'

  resources :merchants
  resources :users
  resources :products
  resources :users do
    member do
      get 'receipt', to: 'users#show_receipt'
    end
  end
  resources :orders, only: [:new, :create, :show, :index]
  resources :payments, only: [:new, :create, :show]
  resources :transactions, only: [:index, :show]

  root 'top#main'
  
  get 'get_image/:id', to: 'products#get_image'
end
