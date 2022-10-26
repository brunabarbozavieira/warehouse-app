require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe 'gera um número de série' do 
    it 'ao criar um StockProduct' do
      user = User.create!(email: 'sergio@email.com', password: '12345678', name: 'Sergio')
      warehouse = Warehouse.create!(name: 'Galpão Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Atlântica, 50', cep: '80000000', description: 'Perto do Aeroporto')
      supplier = Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '37856483027154', full_address: 'Torre da Industria, 38', city: 'Teresina', state: 'PI', email: 'venda@spark.com')
      order = Order.create!(user:user, warehouse:warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now, status: :delivered) 
      product = ProductModel.create!(name: 'SoundBar 7.1 Surroud', weigth: 3000, width: 80, height: 15, depth: 20, sku: 'SOU71-SAMSU-NOIZ7700', supplier: supplier)
      
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)

      expect(stock_product.serial_number.length).to eq 20
    end
    it 'e não é modificado' do 
      user = User.create!(email: 'sergio@email.com', password: '12345678', name: 'Sergio')
      first_warehouse = Warehouse.create!(name: 'Galpão Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Atlântica, 50', cep: '80000000', description: 'Perto do Aeroporto')
      second_warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av do porto, 1000', cep: '20000000', description: 'Galpão do rio')
      supplier = Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '37856483027154', full_address: 'Torre da Industria, 38', city: 'Teresina', state: 'PI', email: 'venda@spark.com')
      order = Order.create!(user:user, warehouse:first_warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now, status: :delivered) 
      product = ProductModel.create!(name: 'SoundBar 7.1 Surroud', weigth: 3000, width: 80, height: 15, depth: 20, sku: 'SOU71-SAMSU-NOIZ7700', supplier: supplier)
      stock_product = StockProduct.create!(order: order, warehouse: first_warehouse, product_model: product)
      original_serial_number = stock_product.serial_number

      stock_product.update(warehouse: second_warehouse)

      expect(original_serial_number).to eq stock_product.serial_number
    end
  end
  describe '#available?' do 
    it 'true se não tiver destino' do 
      user = User.create!(email: 'sergio@email.com', password: '12345678', name: 'Sergio')
      warehouse = Warehouse.create!(name: 'Galpão Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Atlântica, 50', cep: '80000000', description: 'Perto do Aeroporto')
      supplier = Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '37856483027154', full_address: 'Torre da Industria, 38', city: 'Teresina', state: 'PI', email: 'venda@spark.com')
      order = Order.create!(user:user, warehouse:warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now, status: :delivered) 
      product = ProductModel.create!(name: 'SoundBar 7.1 Surroud', weigth: 3000, width: 80, height: 15, depth: 20, sku: 'SOU71-SAMSU-NOIZ7700', supplier: supplier)
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)

      expect(stock_product.available?).to eq true
    end
    it 'false se tiver destino' do 
      user = User.create!(email: 'sergio@email.com', password: '12345678', name: 'Sergio')
      warehouse = Warehouse.create!(name: 'Galpão Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Atlântica, 50', cep: '80000000', description: 'Perto do Aeroporto')
      supplier = Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '37856483027154', full_address: 'Torre da Industria, 38', city: 'Teresina', state: 'PI', email: 'venda@spark.com')
      order = Order.create!(user:user, warehouse:warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now, status: :delivered) 
      product = ProductModel.create!(name: 'SoundBar 7.1 Surroud', weigth: 3000, width: 80, height: 15, depth: 20, sku: 'SOU71-SAMSU-NOIZ7700', supplier: supplier)
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)

      stock_product.create_stock_product_destination!(recipient: 'João', address: "Ruas das Flores")

      expect(stock_product.available?).to eq false
    end
  end
end
