class RenameReviwerNameToReviewerName < ActiveRecord::Migration[5.2]
  def change
    rename_column :reviews, :reviwer_name, :reviewer_name
  end
end
