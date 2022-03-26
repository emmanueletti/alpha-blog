Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # "resources" syntax is a shortcut parsed by RAILS to give us all the relevant CRUD
  # routes for interacting with existing database resources referenced via a symbol.
  # Need to have the symbol be of a resource already created in the db schema and
  # managed via a model file in the model folder.
  # Can select just the routes needed by adding only: [:ROUTE_CONTROLLER_ACTION_NAME]
  # e.g resources :articles, only: [:show, :index, :create]

  # to see all current routes in the app run "rails routes --expanded" in the terminal.
  resources :articles
end
