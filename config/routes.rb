TnwHackathon::Application.routes.draw do

  get '/', to: 'staticpages#home', as:'home_page'

  resources :sessions
  resources :creditcards

  resources :customers


end
