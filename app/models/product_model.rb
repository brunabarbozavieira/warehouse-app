class ProductModel < ApplicationRecord
  belongs_to :supplier
  validates :name, :weigth, :width, :height, :depth, :sku, presence: true
  validates :sku, uniqueness: true
  validates :sku, length: { is: 20 }
  validates :weigth, :width, :height, :depth, comparison: {greater_than: 0 }
end
