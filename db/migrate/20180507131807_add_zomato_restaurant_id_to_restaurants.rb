class AddZomatoRestaurantIdToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :zomato_restaurant_id, :integer
    add_index :restaurants, :zomato_restaurant_id
  end
end
