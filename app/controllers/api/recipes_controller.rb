class Api::RecipesController < ApplicationController
  def show
    @recipe = Recipe.find_by(id: params[:id])
    render "show.json.jb"
  end

  def create
    @recipe = Recipe.new(
      title: "Individual Apple Crisp",
      prep_time: 45,
      servings: 1,
      user_id: 1,
      source_url: "https://www.epicurious.com/recipes/food/views/individual-apple-crisp",
    )
    @recipe.save

    @ingredient = Ingredient.new(
      name: "apple",
    )
    @ingredient.save
    @ingredient = Ingredient.new(
      name: "lemon juice",
    )
    @ingredient.save
    @ingredient = Ingredient.new(
      name: "brown sugar",
    )
    @ingredient.save
    @ingredient = Ingredient.new(
      name: "cinnamon",
    )
    @ingredient.save
    @ingredient = Ingredient.new(
      name: "flour",
    )
    @ingredient.save
    @ingredient = Ingredient.new(
      name: "pecans",
    )
    @ingredient.save
    @ingredient = Ingredient.new(
      name: "butter",
    )
    @ingredient.save
    @ingredient = Ingredient.new(
      name: "kosher salt",
    )
    @ingredient.save
    @ingredient = Ingredient.new(
      name: "vanilla ice cream",
    )
    @ingredient.save

    @direction = Direction.new(
      number: 1,
      step: "Preheat oven to 375°F.",
      recipe_id: 5,
    )
    @direction.save
    @direction = Direction.new(
      number: 2,
      step: "Toss apple, lemon juice, 2 tsp. brown sugar, and 1/8 tsp. cinnamon in a medium bowl, then pack into baking dish.",
      recipe_id: 5,
    )
    @direction.save
    @direction = Direction.new(
      number: 3,
      step: "Mix flour, pecans, butter, salt, and remaining 1 Tbsp. brown sugar and 1/8 tsp. cinnamon in a medium bowl, squeezing and crumbling with your fingers until mixture comes together in little clumps. Scatter over apples.",
      recipe_id: 5,
    )
    @direction.save
    @direction = Direction.new(
      number: 4,
      step: "Bake crisp until apples are bubbling and top is golden brown, about 35 minutes. Serve with ice cream, if desired.",
      recipe_id: 5,
    )
    @direction.save

    @image = Image.new(
      url: "https://assets.epicurious.com/photos/59bfefbb335b1f2cee3c8f1d/6:4/w_620%2Ch_413/Apple-Crisp-for-One-13092017.jpg",
      alt: "baked apple crisp",
      recipe_id: 5,
    )

    @ingredient_recipe = IngredientRecipe.new(
      ingredient_id: 19,
      recipe_id: 5,
      measurement_in_ml: nil,
      number_of: 1,
    )
    @ingredient_recipe.save

    @ingredient_recipe = IngredientRecipe.new(
      ingredient_id: 20,
      recipe_id: 5,
      measurement_in_ml: 5,
      number_of: nil,
    )
    @ingredient_recipe.save

    @ingredient_recipe = IngredientRecipe.new(
      ingredient_id: 21,
      recipe_id: 5,
      measurement_in_ml: 25,
      number_of: nil,
    )
    @ingredient_recipe.save

    @ingredient_recipe = IngredientRecipe.new(
      ingredient_id: 22,
      recipe_id: 5,
      measurement_in_ml: 1,
      number_of: nil,
    )
    @ingredient_recipe.save

    @ingredient_recipe = IngredientRecipe.new(
      ingredient_id: 23,
      recipe_id: 5,
      measurement_in_ml: 30,
      number_of: nil,
    )
    @ingredient_recipe.save

    @ingredient_recipe = IngredientRecipe.new(
      ingredient_id: 24,
      recipe_id: 5,
      measurement_in_ml: 15,
      number_of: nil,
    )
    @ingredient_recipe.save

    @ingredient_recipe = IngredientRecipe.new(
      ingredient_id: 25,
      recipe_id: 5,
      measurement_in_ml: 15,
      number_of: nil,
    )
    @ingredient_recipe.save

    @ingredient_recipe = IngredientRecipe.new(
      ingredient_id: 26,
      recipe_id: 5,
      measurement_in_ml: 0.6,
      number_of: nil,
    )
    @ingredient_recipe.save

    @ingredient_recipe = IngredientRecipe.new(
      ingredient_id: 27,
      recipe_id: 5,
      measurement_in_ml: nil,
      number_of: 1,
    )
    @ingredient_recipe.save

    render "show.json.jb"
  end
end
