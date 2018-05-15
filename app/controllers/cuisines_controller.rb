class CuisinesController < ApplicationController
  def index
    cuisines = Cuisine.all
    render json: cuisines, status: :ok
  end
end
