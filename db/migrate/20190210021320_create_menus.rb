class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.integer :category_id, null: false
      t.integer :genre_id   , null: false
      t.string  :name,        null: false
      t.string  :description
      t.timestamps            null: false
    end
  end
end
