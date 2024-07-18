class Customer < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :province
  has_one :customer_address, dependent: :destroy

  validates :username, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true

  accepts_nested_attributes_for :customer_address, allow_destroy: true

  def self.ransackable_associations(auth_object = nil)
    ["province", "customer_address"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["username", "email", "created_at", "id", "province_id", "updated_at"]
  end
end
