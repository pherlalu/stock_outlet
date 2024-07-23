class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :province
  has_many :order_items, dependent: :destroy

  enum status: { pending: 'pending', paid: 'paid', shipped: 'shipped', canceled: 'canceled' }

  validates :order_date, :status, presence: true

  before_create :set_historical_tax_rates

  def self.ransackable_associations(auth_object = nil)
    ["customer", "order_items", "province"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "customer_id", "id", "stripe_payment_id", "updated_at", "province_id", "total", "status"]
  end

  private

  def set_historical_tax_rates
    self.historical_gst_rate = province.gst_rate
    self.historical_pst_rate = province.pst_rate
    self.historical_hst_rate = province.hst_rate
    self.historical_qst_rate = province.qst_rate
  end
end
