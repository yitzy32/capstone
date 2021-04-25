class Api::IngredientsController < ApplicationController
  def create
    @ingredient = Ingredient.new(name: params[:name])
    @ingredient.save
    render "show.json.jb"
  end
end
