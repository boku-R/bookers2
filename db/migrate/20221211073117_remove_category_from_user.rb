class RemoveCategoryFromUser < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :category, :string
  end
end
