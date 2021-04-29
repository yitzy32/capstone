class Api::PantryItemsController < ApplicationController
  def index
    @pantry_items = PantryItem.where(user_id: current_user.id)
    render "index.json.jb"
  end

  def show
    @pantry_item = PantryItem.find_by(id: params[:id])
    render "show.json.jb"
  end

  def create
    @pantry_item = PantryItem.new(
      ingredient_id: params[:ingredient_id],
      measurement_in_ml: params[:measurement_in_ml],
      user_id: current_user.id,
    )
    @pantry_item.save
    render "show.json.jb"
  end

  def update
    @pantry_item = PantryItem.find_by(id: params[:id])
    @pantry_item.measurement_in_ml = params[:measurement_in_ml] || @pantry_item.measurement_in_ml
    @pantry_item.number_of = params[:number_of] || @pantry_item.number_of
    @pantry_item.save
    render "show.json.jb"
  end

  def destroy
    @pantry_item = PantryItem.find_by(id: params[:id])
    render json: { message: "Pantry Item Successfully Removed" }
    @pantry_item.destroy
  end
end
