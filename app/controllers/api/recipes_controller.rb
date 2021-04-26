class Api::RecipesController < ApplicationController
  def index
    @recipes = Recipe.where(id: current_user.id)
    render "index.json.jb"
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
end
