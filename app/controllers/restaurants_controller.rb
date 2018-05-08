class RestaurantsController < ApplicationController
  def index
    restaurants = Restaurant.all
    render json: restaurants, status: :ok
  end

  def show
    restaurant = Restaurant.find(params[:id])
    render json: restaurant, status: :ok
  end

  def create
    restaurant = Restaurant.new(restaurant_params)
    if restaurant.save
      render json: { restaurant: restaurant }, status: :created
    else
      render json: { restaurant: restaurant.errors }, status: :unprocessable_entity
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:address, :cuisine, :maximum_delivery_time, :name, :tenbis)
  end
end
