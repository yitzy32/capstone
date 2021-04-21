class Api::RecipesController < ApplicationController
  def show
    @recipe = Recipe.find_by(id: params[:id])
    render "show.json.jb"
  end

  def create
    @recipe = Recipe.new(
      title: params[:title],
      prep_time: params[:prep_time],
      servings: params[:servings],
      user_id: current_user.id,
      source_url: params[:source_url],
    )
    @recipe.save!

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
