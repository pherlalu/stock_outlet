class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :province
  has_many :order_items, dependent: :destroy

  # validates :order_date, presence: true
  # validates :status, presence: true
  # validates :stripe_payment_id, presence: true
  def self.ransackable_associations(auth_object = nil)
    ["customer", "order_items", "province"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "customer_id", "id", "stripe_payment_id", "updated_at", "province_id", "total"]
  end
end
