class RemoveCuisineFromRestaurants < ActiveRecord::Migration[5.2]
  def change
    remove_column :restaurants, :cuisine
  end
end
