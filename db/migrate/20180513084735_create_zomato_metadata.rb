class CreateZomatoMetadata < ActiveRecord::Migration[5.2]
  def change
    create_table :zomato_metadata do |t|
      t.decimal :rating, precision: 2, scale: 1, default: 0.0
      t.integer :votes, default: 0
      t.integer :zomato_restaurant_id
      t.integer :restaurant_id
      t.index :restaurant_id, unique: true
      t.timestamps
    end
  end
end
