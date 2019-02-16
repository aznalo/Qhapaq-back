class CreateSteps < ActiveRecord::Migration[5.2]
  def change
    create_table :steps do |t|
      t.integer :menu_id, null: false
      t.string  :description, null: false
      t.timestamps
    end
  end
end
