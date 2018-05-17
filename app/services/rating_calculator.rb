class RatingCalculator
  def self.calculate(restaurant)
    return 0 if restaurant.zomato_metadata.blank? && @review.blank?

    (((restaurant.zomato_metadata.votes * restaurant.zomato_metadata.rating) + (restaurant.reviews.sum(:rating) * restaurant.reviews.size)) / (restaurant.zomato_metadata.votes + restaurant.reviews.size)).round(1)
  end
end
