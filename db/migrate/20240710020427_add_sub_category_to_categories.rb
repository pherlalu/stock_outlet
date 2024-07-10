class AddSubCategoryToCategories < ActiveRecord::Migration[7.1]
  def change
    add_reference :categories, :sub_category, foreign_key: { to_table: :categories }
  end
end
