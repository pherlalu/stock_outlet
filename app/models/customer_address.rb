class CustomerAddress < ApplicationRecord
  belongs_to :customer

  validates :address, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "customer_id", "id", "updated_at"]
  end
end
