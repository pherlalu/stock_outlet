class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  before_create :set_historical_prices

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "is_cart", "order_id", "product_id", "quantity", "subtotal", "unit_price", "updated_at"]
  end

  private

  def set_historical_prices
    self.historical_unit_price = product.price
    self.historical_subtotal = quantity * product.price
  end
end
