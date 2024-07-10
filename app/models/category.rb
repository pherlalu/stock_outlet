class Category < ApplicationRecord
  has_many :product_categories
  has_many :products, through: :product_categories

  has_many :sub_categories, class_name: 'Category', foreign_key: 'sub_category_id'
  belongs_to :parent_category, class_name: 'Category', optional: true, foreign_key: 'sub_category_id'

  def to_param
    name
  end

  def subtree_ids
    sub_category_ids + sub_categories.flat_map(&:subtree_ids)
  end

  validates :name, presence: true
 
end
