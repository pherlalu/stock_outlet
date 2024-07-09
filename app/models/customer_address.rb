class CustomerAddress < ApplicationRecord
  belongs_to :customer

  validates :address, presence: true
end
