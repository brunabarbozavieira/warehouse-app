require 'rails_helper' 

describe 'Usuário vê o estoque' do 
  it 'na tela de galpão' do 
    user = User.create!(email: 'andre@email.com', password: 'password', name: 'Andre')
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', registration_number: '46734987000198', full_address: 'Av Nações Unidas, 100', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
    warehouse = Warehouse.create!(name: 'Galpão Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Atlântica, 50', cep: '80000000', description: 'Perto do Aeroporto')
    order = Order.create!(user: user, warehouse:warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    product_a = ProductModel.create!(name: 'TV 32', weigth: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
    product_b = ProductModel.create!(name: 'SoundBar 7.1 Surroud', weigth: 3000, width: 80, height: 15, depth: 20, sku: 'SOU71-SAMSU-NOIZ7700', supplier: supplier)
    product_c = ProductModel.create!(name: 'Notbook', weigth: 3000, width: 80, height: 15, depth: 20, sku: 'NOT591-SAMSU-PROZ550', supplier: supplier)
    3.times {StockProduct.create!(order:order,product_model: product_a, warehouse: warehouse)}
    2.times {StockProduct.create!(order:order,product_model: product_b, warehouse: warehouse)}

    login_as user
    visit root_path
    click_on 'Galpão Maceio'

    within "section#stock_products" do 
      expect(page).to have_content 'Itens em Estoque'
      expect(page).to have_content '3 x TV32-SAMSU-XPTO90000'
      expect(page).to have_content '2 x SOU71-SAMSU-NOIZ7700'
      expect(page).not_to have_content 'NOT591-SAMSU-PROZ550'
    end
  end

  it 'e da baixa em um produto' do 
    user = User.create!(email: 'andre@email.com', password: 'password', name: 'Andre')
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', registration_number: '46734987000198', full_address: 'Av Nações Unidas, 100', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
    warehouse = Warehouse.create!(name: 'Galpão Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Atlântica, 50', cep: '80000000', description: 'Perto do Aeroporto')
    order = Order.create!(user: user, warehouse:warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    product_a = ProductModel.create!(name: 'TV 32', weigth: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
    2.times {StockProduct.create!(order:order,product_model: product_a, warehouse: warehouse)}

    login_as user
    visit root_path
    click_on 'Galpão Maceio'
    select 'TV32-SAMSU-XPTO90000', from: 'Item para Saída'
    fill_in 'Destinatário', with: 'Maria Ferreira'
    fill_in 'Endereço de Destino', with: 'Rua das Palmeiras, 100 - Campinas - São Paulo'
    click_on 'Confirmar Retirada' 

    expect(current_url).to eq warehouse_url(warehouse.id)
    expect(page).to have_content 'Item retirado com sucesso.'
    expect(page).to have_content '1 x TV32-SAMSU-XPTO90000'
    end

    #it 'e não da baixa em um mesmo produto mais que uma vez' do 
     # user = User.create!(email: 'andre@email.com', password: 'password', name: 'Andre')
     # supplier = Supplier.create!(corporate_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', registration_number: '46734987000198', full_address: 'Av Nações Unidas, 100', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
      #warehouse = Warehouse.create!(name: 'Galpão Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Atlântica, 50', cep: '80000000', description: 'Perto do Aeroporto')
     # order = Order.create!(user: user, warehouse:warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
     # product = ProductModel.create!(name: 'TV 32', weigth: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
      #stock_product = StockProduct.create!(order:order,product_model: product, warehouse: warehouse)
      #stock_product.create_stock_product_destination!(recipient: 'João', address: 'Ruas das Flores')
    #end
end