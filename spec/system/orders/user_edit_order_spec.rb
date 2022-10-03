require 'rails_helper'

describe 'Usuário edita pedido' do
  it 'e deve estar autenticado' do 
    user = User.create!(email: 'sergio@email.com', password: '12345678', name: 'Sergio')
    warehouse = Warehouse.create!(name: 'Galpão Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Atlântica, 50', cep: '80000000', description: 'Perto do Aeroporto')
    supplier = Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '37856483027154', full_address: 'Torre da Industria, 38', city: 'Teresina', state: 'PI', email: 'venda@spark.com')
    order = Order.create!(user:user, warehouse:warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    visit edit_order_url(order.id)

    expect(current_url).to eq new_user_session_url
  end 

  it 'com sucesso' do 
    user = User.create!(email: 'sergio@email.com', password: '12345678', name: 'Sergio')
    warehouse = Warehouse.create!(name: 'Galpão Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Atlântica, 50', cep: '80000000', description: 'Perto do Aeroporto')
    supplier = Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '37856483027154', full_address: 'Torre da Industria, 38', city: 'Teresina', state: 'PI', email: 'venda@spark.com')
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '46734987640198', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
    order = Order.create!(user:user, warehouse:warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Editar'
    fill_in 'Data prevista de entrega', with: '12/12/2022'
    select 'ACME LTDA - CNPJ: 46.734.987/6401-98', from: 'Fornecedor'
    click_on 'Gravar'

    expect(page).to have_content 'Pedido atualizado com sucesso.'
    expect(page).to have_content 'Fornecedor: ACME LTDA - CNPJ: 46.734.987/6401-98 '
    expect(page).to have_content 'Data prevista de entrega: 12/12/2022'
  end

  it 'caso seja o responsável' do 
    sergio = User.create!(email: 'sergio@email.com', password: '12345678', name: 'Sergio')
    andre = User.create!(email: 'andre@email.com', password: 'password', name: 'Andre')
    warehouse = Warehouse.create!(name: 'Galpão Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Atlântica, 50', cep: '80000000', description: 'Perto do Aeroporto')
    supplier = Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '37856483027154', full_address: 'Torre da Industria, 38', city: 'Teresina', state: 'PI', email: 'venda@spark.com')
    order = Order.create!(user: sergio, warehouse:warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    login_as(andre)
    visit edit_order_url(order.id)

    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não possui acesso a este pedido.'
  end
end