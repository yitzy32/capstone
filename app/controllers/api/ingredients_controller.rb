class Api::IngredientsController < ApplicationController
  def index
    @ingredients = Ingredient.all
    render "index.json.jb"
  end

  def create
    @ingredient = Ingredient.new(name: params[:name])
    @ingredient.save
    render "show.json.jb"
  end
end
