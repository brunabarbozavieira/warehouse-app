require 'rails_helper'

describe 'Usuário adiciona itens ao pedido' do 
  it 'com sucesso' do 
    user = User.create!(email: 'andre@email.com', password: 'password', name: 'Andre')
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', registration_number: '46734987000198', full_address: 'Av Nações Unidas, 100', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
    warehouse = Warehouse.create!(name: 'Galpão Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Atlântica, 50', cep: '80000000', description: 'Perto do Aeroporto')
    order = Order.create!(user: user, warehouse:warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    product_a = ProductModel.create!(name: 'TV 32', weigth: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
    product_b = ProductModel.create!(name: 'SoundBar 7.1 Surroud', weigth: 3000, width: 80, height: 15, depth: 20, sku: 'SOU71-SAMSU-NOIZ7700', supplier: supplier)

    login_as user
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'
    select 'TV 32', from: 'Produto'
    fill_in 'Quantidade', with: '8'
    click_on 'Gravar'

    expect(current_url).to eq order_url(order.id)
    expect(page).to have_content '8 x TV 32'
    expect(page).to have_content 'Item adicionado com sucesso.'
  end

  it ' e não vê produtos de outros fornecedores' do 
    user = User.create!(email: 'andre@email.com', password: 'password', name: 'Andre')
    supplier_a = Supplier.create!(corporate_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', registration_number: '46734987000198', full_address: 'Av Nações Unidas, 100', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
    supplier_b = Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '37856483027154', full_address: 'Torre da Industria, 38', city: 'Teresina', state: 'PI', email: 'venda@spark.com')
    warehouse = Warehouse.create!(name: 'Galpão Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Atlântica, 50', cep: '80000000', description: 'Perto do Aeroporto')
    order = Order.create!(user: user, warehouse:warehouse, supplier: supplier_a, estimated_delivery_date: 1.day.from_now)
    product_a = ProductModel.create!(name: 'TV 32', weigth: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier_a)
    product_b = ProductModel.create!(name: 'SoundBar 7.1 Surroud', weigth: 3000, width: 80, height: 15, depth: 20, sku: 'SOU71-SAMSU-NOIZ7700', supplier: supplier_b)

    login_as user 
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'

    expect(page).to have_content 'TV 32'
    expect(page).not_to have_content 'SoundBar 7.1 Surroud'
  end
end