require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#description' do 
  it 'exibe nome e email' do
    u = User.new(name: 'Julia', email: 'julia@email.com')
    
    expect(u.description).to eq 'Julia - julia@email.com'
  end
  end

  describe '#valid?' do 
    it 'código é obrigatório' do 
      user = User.create!(email: 'sergio@email.com', password: '12345678', name: 'Sergio')
      warehouse = Warehouse.create!(name: 'Galpão Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Atlântica, 50', cep: '80000000', description: 'Perto do Aeroporto')
      supplier = Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '37856483027154', full_address: 'Torre da Industria, 38', city: 'Teresina', state: 'PI', email: 'venda@spark.com')
      order = Order.new(user:user, warehouse:warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now)

      expect(order.valid?).to eq true 
    end

    it 'data prevista de entrega é obrigatório' do 
      order = Order.new(estimated_delivery_date: '')

      order.valid?

      expect(order.errors.include? :estimated_delivery_date).to eq true 
    end

    it 'data prevista de entrega não deve estar no passado' do 
      order = Order.new(estimated_delivery_date: 1.day.ago)

      order.valid?
      
      expect(order.errors.include? :estimated_delivery_date).to eq true 
      expect(order.errors[:estimated_delivery_date]).to include "deve estar no futuro."
    end

    it 'data prevista de entrega não deve estar no presente' do 
      order = Order.new(estimated_delivery_date: Date.today)

      order.valid?
      
      expect(order.errors.include? :estimated_delivery_date).to eq true 
      expect(order.errors[:estimated_delivery_date]).to include "deve estar no futuro."
    end

    it 'data prevista de entrega deve estar no futuro' do 
      order = Order.new(estimated_delivery_date: 1.day.from_now)

      order.valid?
      
      expect(order.errors.include? :estimated_delivery_date).to eq false
    end

  end

  describe 'gera um código aleatório' do 
    it 'ao criar um novo pedido' do 
      user = User.create!(email: 'sergio@email.com', password: '12345678', name: 'Sergio')
      warehouse = Warehouse.create!(name: 'Galpão Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Atlântica, 50', cep: '80000000', description: 'Perto do Aeroporto')
      supplier = Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '37856483027154', full_address: 'Torre da Industria, 38', city: 'Teresina', state: 'PI', email: 'venda@spark.com')
      order = Order.new(user:user, warehouse:warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now)

      order.save!

      expect(order.code).not_to be_empty
      expect(order.code.length).to eq 10
    end

    it 'e o código é único' do 
      user = User.create!(email: 'sergio@email.com', password: '12345678', name: 'Sergio')
      warehouse = Warehouse.create!(name: 'Galpão Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Atlântica, 50', cep: '80000000', description: 'Perto do Aeroporto')
      supplier = Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '37856483027154', full_address: 'Torre da Industria, 38', city: 'Teresina', state: 'PI', email: 'venda@spark.com')
      first_order = Order.create!(user:user, warehouse:warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now)
      second_order = Order.new(user:user, warehouse:warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now)


      second_order.save!

      expect(second_order.code).not_to eq first_order.code
    end

    it 'e não deve ser modificado' do 
      user = User.create!(email: 'sergio@email.com', password: '12345678', name: 'Sergio')
      warehouse = Warehouse.create!(name: 'Galpão Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Atlântica, 50', cep: '80000000', description: 'Perto do Aeroporto')
      supplier = Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '37856483027154', full_address: 'Torre da Industria, 38', city: 'Teresina', state: 'PI', email: 'venda@spark.com')
      order = Order.create!(user:user, warehouse:warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now)
      original_code = order.code

      order.update!(estimated_delivery_date: 1.month.from_now)

      expect(order.code).to eq original_code
    end
  end
end
