Rails.application.routes.draw do
  # EXAMPLE HTML ROUTE
  # get "/photos" => "photos#index"

  # EXAMPLE JSON ROUTE WITH API NAMESPACE
  namespace :api do
    post "/users" => "users#create"

    post "/sessions" => "sessions#create"

    get "/pantry_items" => "pantry_items#index"
    post "/pantry_items" => "pantry_items#create"
    patch "/pantry_items/:id" => "pantry_items#update"

    get "/recipes" => "recipes#index"
    get "/recipes/:id" => "recipes#show"
    post "/recipes" => "recipes#create"

    post "/ingredients" => "ingredients#create"
  end
end
