class Api::ApiSearchesController < ApplicationController
  def index
    response = HTTP.get("https://api.spoonacular.com/recipes/complexSearch?query=#{params[:search]}&fillIngredients=true&instructionsRequired=true&addRecipeInformation=true&apiKey=#{Rails.application.credentials.spoonacular_api[:api_key]}").to_s

    @data = JSON.parse(response)
    @recipes = []
    @data["results"].each do |recipe|
      @recipe = {}
      @title = recipe["title"]
      @prep_time = recipe["readyInMinutes"]
      @image = recipe["image"]
      @servings = recipe["servings"]
      @source_url = recipe["sourceUrl"]
      @recipe = { title: @title, prep_time: @prep_time, image: @image, servings: @servings, source_url: @source_url }
      @recipes << @recipe

      @ingredients = []
      recipe["extendedIngredients"].each do |extended_ingredient|
        @name = extended_ingredient["name"]
        @amount = extended_ingredient["amount"]
        @unit = extended_ingredient["unit"]
        @ingredients << { name: @name, amount: @amount, unit: @unit }
        @recipe[:ingredients] = @ingredients
      end
      @directions = []
      recipe["analyzedInstructions"][0]["steps"].each do |step|
        @number = step["number"]
        @step = step["step"]
        @directions << { number: @number, step: @step }
        @recipe[:directions] = @directions
      end
    end
    ap @recipes
    render "index.json.jb"
  end

  def create
    @recipe = Recipe.new(
      title: params[:title],
      prep_time: params[:prep_time],
      servings: params[:servings],
      user_id: current_user.id,
      source_url: params[:source_url],
    )
    @recipe.save

    params[:ingredients].each do |ingredient|
      @ingredient = Ingredient.new(
        name: ingredient[:name],
      )
      @ingredient.save
    end

    params[:directions].each do |direction|
      @direction = Direction.new(
        number: direction[:number],
        step: direction[:step],
        recipe_id: @recipe.id,
      )
      @direction.save
    end

    params[:ingredients].each do |ingredient|
      if ingredient[:unit] == "cup" || ingredient[:unit] == "cups"
        cup_calculation = ingredient[:amount] * 237
      elsif ingredient[:unit] == "tablespoon" || ingredient[:unit] == "tablespoons"
        tbs_calulation = ingredient[:amount] * 14.786
      else
        cup_calculation = 0
      end
      @ingredient_recipe = IngredientRecipe.new(
        ingredient_id: @ingredient.id,
        recipe_id: @recipe.id,
        measurement_in_ml: cup_calculation,
      )
      @ingredient_recipe.save
    end

    render "show.json.jb"
  end

  # {
  #   "title": "Honey Crescents",
  #   "prep_time": 45,
  #   "image": "https://spoonacular.com/recipeImages/647204-312x231.jpg",
  #   "servings": 4,
  #   "source_url": "https://www.foodista.com/recipe/XFYNNJZS/honey-crescents",
  #   "ingredients": [
  #     {
  #       "name": "yeast",
  #       "amount": 1.0,
  #       "unit": ""
  #     },
  #     {
  #       "name": "salt",
  #       "amount": 1.0,
  #       "unit": "teaspoon"
  #     }
  #   "directions": [
  #     {
  #       "number": 1,
  #       "step": "In a bowl cream the yeast with 1/4 cup milk."
  #     },
  #     {
  #       "number": 2,
  #       "step": "Let stand about 10 minutes."
  #     },
  # }
end
