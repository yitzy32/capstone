Rails.application.routes.draw do
  # EXAMPLE HTML ROUTE
  # get "/photos" => "photos#index"

  # EXAMPLE JSON ROUTE WITH API NAMESPACE
  namespace :api do
    post "/users" => "users#create"

    post "/sessions" => "sessions#create"

    get "/pantry_items" => "pantry_items#index"
    post "/pantry_items" => "pantry_items#create"
    delete "/pantry_items/:id" => "pantry_items#destroy"

    get "/recipes" => "recipes#index"
    get "/recipes/:id" => "recipes#show"
    post "/recipes" => "recipes#create"
    patch "/recipes/:id" => "recipes#update"

    get "/ingredients" => "ingredients#index"
    post "/ingredients" => "ingredients#create"
  end
end
