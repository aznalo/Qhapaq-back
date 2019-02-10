class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.integer :genre_id, null: false
      t.string  :name,     null: false
      t.string  :description
      t.timestamps         null: false
    end
  end
end
