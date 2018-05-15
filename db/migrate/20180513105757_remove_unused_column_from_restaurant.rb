class RemoveUnusedColumnFromRestaurant < ActiveRecord::Migration[5.2]
  def change
    remove_column :restaurants, :zomato_rating
    remove_column :restaurants, :weeat_rating
    remove_column :restaurants, :zomato_restaurant_id
  end
end
