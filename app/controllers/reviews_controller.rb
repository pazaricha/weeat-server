class ReviewsController < ApplicationController
  def create
    restaurant = Restaurant.find(params[:restaurant_id])
    review = restaurant.reviews.new(review_params)

    if review.save
      render json: { review: review }, status: :created
    else
      render json: { restaurant: review.errors }, status: :unprocessable_entity
    end
  end

  def review_params
    params.require(:review).permit(:reviewer_name, :rating, :comment)
  end
end
