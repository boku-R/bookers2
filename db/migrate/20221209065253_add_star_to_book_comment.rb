class AddStarToBookComment < ActiveRecord::Migration[6.1]
  def change
    add_column :book_comments, :star, :float
  end
end
