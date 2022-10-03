class Supplier < ApplicationRecord
  validates :corporate_name, :brand_name, :registration_number, presence: true
  validates :registration_number, uniqueness: true
  validates :registration_number, length: { is: 14 }
  validates :registration_number, numericality: { only_integer: true }

  def description
    "#{corporate_name} - CNPJ: #{registration_number[0..1]}.#{registration_number[2..4]}.#{registration_number[5..7]}/#{registration_number[8..11]}-#{registration_number[12..13]}"
  end
end
