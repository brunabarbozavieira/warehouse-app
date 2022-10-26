class OrderItem < ApplicationRecord
  belongs_to :product_model
  belongs_to :order

  validates :quantity, comparison: {greater_than: 0 }
end
