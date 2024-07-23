class Customer < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :province
  has_many :orders
  
  validates :username, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true
  validates :address, presence: true

  def self.ransackable_associations(auth_object = nil)
    ["province"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["username", "email", "created_at", "id", "province_id", "updated_at", "address"]
  end
end
