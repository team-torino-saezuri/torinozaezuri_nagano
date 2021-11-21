class Address < ApplicationRecord

  belongs_to :customer

  validates :name, presence: true
  validates :address, presence: true
  validates :postal_code, length: {is: 7}, numericality: { only_integer: true }

  def order_address
    self.postal_code + self.address + self.name
  end

end
