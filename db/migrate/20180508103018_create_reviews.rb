class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :reviwer_name
      t.integer :rating
      t.text :comment
      t.references :restaurant

      t.timestamps
    end
  end
end
