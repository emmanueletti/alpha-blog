Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'pages#home'

  # "resources" syntax is a shortcut parsed by RAILS to give us all the relevant CRUD
  # routes for interacting with existing database resources referenced via a symbol.
  # Need to have the symbol be of a resource already created in the db schema and
  # managed via a model file in the model folder.
  # Can select just the routes needed by adding only: [:ROUTE_CONTROLLER_ACTION_NAME]
  # e.g resources :articles, only: [:show, :index, :create]

  # to see all current routes in the app run "rails routes --expanded" in the terminal.
  resources :articles

  # interpretation - GET request method, path 'signup', goes to 'new' method in
  # 'users' controller
  get '/signup', to: 'users#new'
  # since we already defined the new route, we can tell Rails not to create it in
  # its resources short hand
  resources :user, except: [:new]
  # post '/users', to: 'users#create'
end
