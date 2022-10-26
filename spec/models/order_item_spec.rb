require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe '#valid' do 
    it 'quantidade tem que ser maior que zero' do 
      order_item = OrderItem.new(quantity: '0')

      order_item.valid?

      expect(order_item.errors.include? :quantity).to eq true 
    end

    it 'quantidade é obrigatório' do 
      order_item = OrderItem.new(quantity: '')

      order_item.valid?

      expect(order_item.errors.include? :quantity).to eq true 
    end
  end
end
