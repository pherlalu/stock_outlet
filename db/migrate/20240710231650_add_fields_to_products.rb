class AddFieldsToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :on_sale, :boolean
    add_column :products, :added_at, :datetime
  end
end
