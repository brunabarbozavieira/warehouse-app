class Warehouse < ApplicationRecord
  validates :name, :code, :city, :description, :address, :cep, :area, presence: true
  validates :code, :name, uniqueness: true
  validates :cep, length: { is: 8 }
  validates :cep, numericality: { only_integer: true }
  has_many :stock_products

  def full_description
    "#{code} - #{name}"
  end
end
