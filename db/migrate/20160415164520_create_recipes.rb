class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :cuisine
      t.string :name
      t.text :instructions
      t.integer :cooking_time

      t.timestamps null: false
    end
  end
end
