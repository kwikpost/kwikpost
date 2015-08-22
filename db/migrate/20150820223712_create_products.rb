class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.decimal :price, :precision => 8, :scale => 2
      t.text :description
      t.boolean :status
      t.boolean :price_fixed
      t.references :user, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true
      t.references :condition, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
