require 'rails_helper'

describe 'Usuário atualiza o status de um pedido' do 
  it 'para entregue e não é o resposável' do 
    sergio = User.create!(email: 'sergio@email.com', password: '12345678', name: 'Sergio')
    andre = User.create!(email: 'andre@email.com', password: 'password', name: 'Andre')
    warehouse = Warehouse.create!(name: 'Galpão Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Atlântica, 50', cep: '80000000', description: 'Perto do Aeroporto')
    supplier = Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '37856483027154', full_address: 'Torre da Industria, 38', city: 'Teresina', state: 'PI', email: 'venda@spark.com')
    order = Order.create!(user: sergio, warehouse:warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    login_as(andre)
    post delivered_order_url(order.id)

    expect(response).to redirect_to root_path
  end

  it 'para cancelado e não é o resposável' do 
    sergio = User.create!(email: 'sergio@email.com', password: '12345678', name: 'Sergio')
    andre = User.create!(email: 'andre@email.com', password: 'password', name: 'Andre')
    warehouse = Warehouse.create!(name: 'Galpão Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Atlântica, 50', cep: '80000000', description: 'Perto do Aeroporto')
    supplier = Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '37856483027154', full_address: 'Torre da Industria, 38', city: 'Teresina', state: 'PI', email: 'venda@spark.com')
    order = Order.create!(user: sergio, warehouse:warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    login_as(andre)
    post canceled_order_url(order.id)

    expect(response).to redirect_to root_path
  end

  it 'para entregue sem estar autenticado' do
    user = User.create!(email: 'andre@email.com', password: 'password', name: 'Andre')
    warehouse = Warehouse.create!(name: 'Galpão Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Atlântica, 50', cep: '80000000', description: 'Perto do Aeroporto')
    supplier = Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '37856483027154', full_address: 'Torre da Industria, 38', city: 'Teresina', state: 'PI', email: 'venda@spark.com')
    order = Order.create!(user: user, warehouse:warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    
    post delivered_order_url(order.id)

    expect(response).to redirect_to new_user_session_url
  end

  it 'para cancelado sem estar autenticado' do
    user = User.create!(email: 'andre@email.com', password: 'password', name: 'Andre')
    warehouse = Warehouse.create!(name: 'Galpão Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Atlântica, 50', cep: '80000000', description: 'Perto do Aeroporto')
    supplier = Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '37856483027154', full_address: 'Torre da Industria, 38', city: 'Teresina', state: 'PI', email: 'venda@spark.com')
    order = Order.create!(user: user, warehouse:warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    
    post canceled_order_url(order.id)

    expect(response).to redirect_to new_user_session_url
  end
end