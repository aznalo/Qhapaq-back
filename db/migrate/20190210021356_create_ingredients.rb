class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
      t.integer :menu_id, null: false
      t.string  :name,    null: false
      t.integer :amount,  null: false, default: 0
      t.integer :cost,    null: false, default: 0
      t.string  :description
      t.timestamps        null: false
    end
  end
end
