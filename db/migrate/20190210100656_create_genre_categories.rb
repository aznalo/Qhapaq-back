class CreateGenreCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :genre_categories do |t|
      t.integer :genre_id
      t.integer :category_id
    end
  end
end
