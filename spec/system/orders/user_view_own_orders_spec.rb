require 'rails_helper'

describe 'Usuário vê seus próprios pedidos' do 
  it 'e deve estar autenticado' do 
    visit root_path
    click_on 'Meus Pedidos'

    expect(current_url).to eq new_user_session_url
  end

  it 'e não vê outros pedidos' do 
    sergio = User.create!(email: 'sergio@email.com', password: '12345678', name: 'Sergio')
    joao = User.create!(email: 'joao@email.com', password: 'password', name: 'João')
    warehouse = Warehouse.create!(name: 'Galpão Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Atlântica, 50', cep: '80000000', description: 'Perto do Aeroporto')
    supplier = Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '37856483027154', full_address: 'Torre da Industria, 38', city: 'Teresina', state: 'PI', email: 'venda@spark.com')
    first_order = Order.create!(user:sergio, warehouse:warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: 'pending')
    second_order = Order.create!(user:joao, warehouse:warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: 'delivered')
    third_order = Order.create!(user:sergio, warehouse:warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: 'canceled')

    login_as(sergio)
    visit root_path
    click_on 'Meus Pedidos'

    expect(page).to have_content first_order.code
    expect(page).to have_content 'Pendente'
    expect(page).not_to have_content second_order.code
    expect(page).not_to have_content 'Entregue'
    expect(page).to have_content third_order.code
    expect(page).to have_content 'Cancelado'

  end

  it 'visita um pedido' do
    user = User.create!(email: 'sergio@email.com', password: '12345678', name: 'Sergio')
    warehouse = Warehouse.create!(name: 'Galpão Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Atlântica, 50', cep: '80000000', description: 'Perto do Aeroporto')
    supplier = Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '37856483027154', full_address: 'Torre da Industria, 38', city: 'Teresina', state: 'PI', email: 'venda@spark.com')
    order = Order.create!(user:user, warehouse:warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code

    expect(page).to have_content 'Detalhes do Pedido'
    expect(page).to have_content order.code
    expect(page).to have_content 'Galpão destino: MCZ - Galpão Maceio'
    expect(page).to have_content 'Fornecedor: Spark Industries Brasil LTDA - CNPJ: 37.856.483/0271-54'
    formatted_date = I18n.localize(1.day.from_now.to_date)
    expect(page).to have_content "Data prevista de entrega: #{formatted_date}"
  end

  it 'e não visita pedidos de outros usuários' do 
    sergio = User.create!(email: 'sergio@email.com', password: '12345678', name: 'Sergio')
    andre = User.create!(email: 'andre@email.com', password: 'password', name: 'Andre')
    warehouse = Warehouse.create!(name: 'Galpão Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Atlântica, 50', cep: '80000000', description: 'Perto do Aeroporto')
    supplier = Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '37856483027154', full_address: 'Torre da Industria, 38', city: 'Teresina', state: 'PI', email: 'venda@spark.com')
    order = Order.create!(user: sergio, warehouse:warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    login_as(andre)
    visit order_url(order.id)

    expect(current_url).not_to eq order_url(order.id)
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não possui acesso a este pedido.'
  end

  it 'e vê itens do pedido' do 
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', registration_number: '46734987000198', full_address: 'Av Nações Unidas, 100', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
    product_a = ProductModel.create!(name: 'TV 32', weigth: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
    product_b = ProductModel.create!(name: 'SoundBar 7.1 Surroud', weigth: 3000, width: 80, height: 15, depth: 20, sku: 'SOU71-SAMSU-NOIZ7700', supplier: supplier)
    product_c = ProductModel.create!(name: 'Produto C', weigth: 3000, width: 80, height: 15, depth: 20, sku: 'PROC91-SAMSU-NOIZ770', supplier: supplier)
    user = User.create!(email: 'andre@email.com', password: 'password', name: 'Andre')
    warehouse = Warehouse.create!(name: 'Galpão Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Atlântica, 50', cep: '80000000', description: 'Perto do Aeroporto')
    order = Order.create!(user: user, warehouse:warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    OrderItem.create!(product_model: product_a, order: order, quantity: 19)
    OrderItem.create!(product_model: product_b, order: order, quantity: 12)

    login_as user
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code

    expect(page).to have_content 'Itens do Pedido'
    expect(page).to have_content '19 x TV 32'
    expect(page).to have_content '12 x SoundBar 7.1 Surroud'
  end
end