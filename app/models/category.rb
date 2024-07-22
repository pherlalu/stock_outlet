class Category < ApplicationRecord
  has_many :product_categories
  has_many :products, through: :product_categories

  has_many :sub_categories, class_name: 'Category', foreign_key: 'sub_category_id'
  accepts_nested_attributes_for :sub_categories, allow_destroy: true
  belongs_to :parent_category, class_name: 'Category', optional: true, foreign_key: 'sub_category_id'

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "id_value", "name", "sub_category_id", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["parent_category", "product_categories", "products", "sub_categories"]
  end

  def to_param
    name
  end

  def subtree_ids
    sub_category_ids + sub_categories.flat_map(&:subtree_ids)
  end

  validates :name, presence: true
 
end
