TnwHackathon::Application.routes.draw do

  resources :credits


  get '/', to: 'staticpages#home', as:'home_page'

  get '/login', to: 'sessions#new'
  get '/signout', to: 'sessions#destroy', as: 'signout'  
  post '/sessions', to: 'sessions#create'
  resources :creditcards

  resources :customers


end
