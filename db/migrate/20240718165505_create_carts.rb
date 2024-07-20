class CreateCarts < ActiveRecord::Migration[7.1]
  def change
    create_table :carts do |t|
      t.string :secret_id
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
