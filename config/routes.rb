Rails.application.routes.draw do
  # EXAMPLE HTML ROUTE
  # get "/photos" => "photos#index"

  # EXAMPLE JSON ROUTE WITH API NAMESPACE
  namespace :api do
    post "/users" => "users#create"

    post "/sessions" => "sessions#create"

    get "/pantry_items" => "pantry_items#index"
    get "/pantry_items/:id" => "pantry_items#show"
    post "/pantry_items" => "pantry_items#create"
    patch "/pantry_items/:id" => "pantry_items#update" # allows user to update amounts manually
    delete "/pantry_items/:id" => "pantry_items#destroy"

    get "/recipes/test" => "recipes#test"
    get "/recipes" => "recipes#index"
    get "/recipes/:id" => "recipes#show"
    post "/recipes" => "recipes#create"
    patch "/recipes/:id" => "recipes#update" # updates all ingredients in pantry that were used to make this recipe

    get "/api_searches" => "api_searches#index"
    post "/api_searches" => "api_searches#create"

    get "/ingredients" => "ingredients#index"
    post "/ingredients" => "ingredients#create"
  end
  get "*path" => "application#index"
end
