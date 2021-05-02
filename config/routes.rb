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

    get "/recipes" => "recipes#index"
    get "/recipes" => "recipes#index_with_api_results"
    get "/recipes/:id" => "recipes#show"
    post "/recipes" => "recipes#create"
    patch "/recipes/:id" => "recipes#update" # updates all ingredients in pantry that were used to make this recipe

    get "/ingredients" => "ingredients#index"
    post "/ingredients" => "ingredients#create"
  end
end
