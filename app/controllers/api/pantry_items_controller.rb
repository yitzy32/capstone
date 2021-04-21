class Api::PantryItemsController < ApplicationController
  def index
    @pantry_items = PantryItem.where(user_id: current_user.id)
    render "index.json.jb"
  end

  def create
    @pantry_item = PantryItem.new(
      ingredient_id: params[:ingredient_id],
      measurement_in_ml: params[:measurement_in_ml],
      user_id: params[:user_id],
    )
    @pantry_item.save
    render "show.json.jb"
  end
end
