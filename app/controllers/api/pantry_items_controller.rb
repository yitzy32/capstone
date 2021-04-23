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

  def update
    @pantry_items = PantryItem.where(user_id: current_user.id)
    params[:ingredients].each do |ingredient|
      @pantry_item = PantryItem.find_by(name: ingredient[:name])
      if @pantry_item.measurement_in_ml != nil
        subtracted_ml = @pantry_item.measurement_in_ml - ingredient[:measurement_in_ml]
        @pantry_item.measurement_in_ml = subtracted_ml
      elsif @pantry_item.number_of != nil
        subtracted_num_of = @pantry_item.number_of - ingredient[:number_of]
        @pantry_item.number_of = subtracted_num_of
      end
      @pantry_item.save
    end
    render "index.json.jb"
  end
end
