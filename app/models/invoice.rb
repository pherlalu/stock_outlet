class Invoice < ApplicationRecord
  belongs_to :order

  validates :invoice_date, presence: true
  # validates :total, numericality: { greater_than_or_equal_to: 0 }
  # validates :payment_method, presence: true
end
