require 'rails_helper'

describe 'Usuário busca por um pedido' do 
  it 'a partir do menu' do
    user = User.create!(email: 'joao@email.com', password: 'password', name: 'João')

    login_as(user)
    visit root_path

    within 'header nav' do 
      expect(page).to have_field 'Buscar Pedido'
      expect(page).to have_button 'Buscar'
    end
  end

  it 'e deve estar autenticado' do
    
    visit root_path

    within 'header nav' do 
      expect(page).not_to have_field 'Buscar Pedido'
      expect(page).not_to have_button 'Buscar'
    end
  end
  
  it 'e encontra um pedido' do
    user = User.create!(email: 'sergio@email.com', password: '12345678', name: 'Sergio')
    warehouse = Warehouse.create!(name: 'Galpão Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Atlântica, 50', cep: '80000000', description: 'Perto do Aeroporto')
    supplier = Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '37856483027154', full_address: 'Torre da Industria, 38', city: 'Teresina', state: 'PI', email: 'venda@spark.com')
    order = Order.create!(user:user, warehouse:warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido', with: order.code
    click_on 'Buscar'

    expect(page).to have_content "Resultados da Busca por: #{order.code}"
    expect(page).to have_content '1 Pedido Encontrado'
    expect(page).to have_content "Código: #{order.code}"
    expect(page).to have_content 'Galpão destino: MCZ - Galpão Maceio'
    expect(page).to have_content 'Fornecedor: Spark Industries Brasil LTDA - CNPJ: 37.856.483/0271-54'
  end

  it 'e encontra multiplos pedidos' do
    user = User.create!(email: 'sergio@email.com', password: '12345678', name: 'Sergio')
    first_warehouse = Warehouse.create!(name: 'Galpão Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Atlântica, 50', cep: '80000000', description: 'Perto do Aeroporto')
    second_warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av do porto, 1000', cep: '20000000', description: 'Galpão do rio')
    supplier = Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '37856483027154', full_address: 'Torre da Industria, 38', city: 'Teresina', state: 'PI', email: 'venda@spark.com')
    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('MCZ0012345')
    first_order = Order.create!(user:user, warehouse:first_warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('MCZ0076584')
    second_order = Order.create!(user:user, warehouse:first_warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('SDU0000000')
    third_order = Order.create!(user:user, warehouse:second_warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido', with: 'MCZ'
    click_on 'Buscar'

    expect(page).to have_content '2 Pedidos Encontrados'
    expect(page).to have_content 'MCZ0012345'
    expect(page).to have_content 'MCZ0076584'
    expect(page).to have_content 'Galpão destino: MCZ - Galpão Maceio'
    expect(page).not_to have_content 'SDU0000000'
    expect(page).not_to have_content 'Galpão destino: SDU - Rio'
  end
end