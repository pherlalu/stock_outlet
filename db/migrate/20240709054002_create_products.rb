class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.decimal :price
      t.string :product_image
      t.string :product_link
      t.string :product_styleno

      t.timestamps
    end
  end
end
