class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  # validates :quantity, numericality: { greater_than: 0 }
  # validates :unit_price, numericality: { greater_than_or_equal_to: 0 }
  # validates :subtotal, numericality: { greater_than_or_equal_to: 0 }
  # validates :Is_cart, inclusion: { in: [true, false] }
end
