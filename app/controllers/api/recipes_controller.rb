class Api::RecipesController < ApplicationController
  def index
    @recipes = Recipe.where(user_id: current_user.id)
    render "index.json.jb"
  end

  def index_with_api_results
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
    render "index_with_api_results.json.jb"
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
    render "show.json.jb"
  end

  def create
    params[:recipes].each do |recipe|
      @recipe = Recipe.new(
        title: recipe[:title],
        prep_time: recipe[:prep_time],
        servings: recipe[:servings],
        source_url: recipe[:source_url],
        user_id: current_user.id,
      )
      @recipe.save!
    end

    params[:directions].each do |direction|
      @direction = Direction.new(
        number: direction[:number],
        step: direction[:step],
        recipe_id: @recipe.id,
      )
      @direction.save!
    end

    params[:ingredients].each do |ingredient|
      @ingredient = Ingredient.new(
        name: ingredient[:name],
      )
      @ingredient.save!

      @ingredient_recipe = IngredientRecipe.new(
        ingredient_id: @ingredient.id,
        recipe_id: @recipe.id,
        measurement_in_ml: ingredient[:measurement_in_ml],
        number_of: ingredient[:number_of],
      )
      @ingredient_recipe.save!
    end

    params[:images].each do |image|
      @image = Image.new(
        url: image[:url],
        alt: image[:alt],
        recipe_id: @recipe.id,
      )
      @image.save!
    end
    render "show.json.jb"
  end

  def update
    @recipe = Recipe.find_by(id: params[:id])
    @recipe.ingredients.each do |ingredient|
      @pantry_item = PantryItem.find_by(ingredient_id: ingredient.id)
      @ingredient_recipe = IngredientRecipe.find_by(ingredient_id: ingredient.id)

      if @pantry_item.measurement_in_ml != nil
        subtracted_ml = @pantry_item.measurement_in_ml - @ingredient_recipe.measurement_in_ml
        @pantry_item.measurement_in_ml = subtracted_ml
        if @pantry_item.measurement_in_ml < 0
          @pantry_item.measurement_in_ml = 0
        end
      elsif @pantry_item.number_of != nil
        subtracted_num_of = @pantry_item.number_of - @ingredient_recipe.number_of
        @pantry_item.number_of = subtracted_num_of
        if @pantry_item.number_of < 0
          @pantry_item.number_of = 0
        end
      end
      @pantry_item.save
    end
    render "show.json.jb"
  end
end
