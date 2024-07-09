class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items
  has_one :invoice

  validates :order_date, presence: true
  validates :status, presence: true
end
