class AddZomatoRatingAndWeeatRatingToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :zomato_rating, :decimal, precision: 2, scale: 1, default: 0.0
    add_column :restaurants, :weeat_rating, :decimal, precision: 2, scale: 1, default: 0.0
  end
end
