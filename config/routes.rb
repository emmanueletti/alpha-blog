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
  resources :users, except: [:new]
  # post '/users', to: 'users#create'

  # login sessions does not have anything to do with the database so does not
  # have to use RESTful convention - here we make up combinations of methods and routes
  get '/login', to: 'sessions#new' # the login form
  post '/login', to: 'sessions#create' # handles login form submission
  delete '/logout', to: 'sessions#destroy' # handles login out

  resources :categories, except: [:destroy]
end
