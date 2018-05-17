class CuisinesController < ApplicationController
  def index
    cuisines = Cuisine.all.order(:name)
    render json: cuisines, status: :ok
  end
end
