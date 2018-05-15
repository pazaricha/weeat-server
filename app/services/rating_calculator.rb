class RatingCalculator
  def initialize(restaurant_id)
    @restaurant = Restaurant.find(restaurant_id)
    @zomato_metadata = @restaurant.zomato_metadata
    @reviews = @restaurant.reviews
  end

  def calculate
    return 0 if @zomato_metadata.blank? && @review.blank?

    (((@zomato_metadata.votes * @zomato_metadata.rating) + (@reviews.sum(:rating) * @reviews.size)) / (@zomato_metadata.votes + @reviews.size)).round(1)
  end
end