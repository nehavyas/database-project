class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :image_url
      t.decimal :price, :precision => 8, :scale => 2
      t.integer :category_id

      t.timestamps
    end
  end
end
