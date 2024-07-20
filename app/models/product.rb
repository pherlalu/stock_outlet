class Product < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  has_many :cart_items

  validates :name, presence: true
  validates :description, presence: true

  before_create :set_added_at

  scope :on_sale, -> { where(on_sale: true) }
  scope :new_products, -> { where('added_at >= ?', 3.days.ago) }
  scope :recently_updated, -> { where('updated_at >= ? AND added_at < ?', 3.days.ago, 3.days.ago) }

  private

  def set_added_at
    self.added_at ||= Time.current
  end

  def self.ransackable_associations(auth_object = nil)
    ["categories", "order_items", "product_categories"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["added_at", "created_at", "description", "id", "id_value", "name", "on_sale", "price", "product_image", "product_link", "product_styleno", "updated_at"]
  end
  
end
