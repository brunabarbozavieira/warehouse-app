class Supplier < ApplicationRecord
  validates :corporate_name, :brand_name, :registration_number, presence: true
  validates :registration_number, uniqueness: true
  validates :registration_number, length: { is: 14 }
  validates :registration_number, numericality: { only_integer: true }
end
