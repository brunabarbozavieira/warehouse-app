require 'rails_helper'

describe 'Usuário cadastra um pedido' do 
  it 'deve estar autenticado' do 
    visit root_path
    click_on 'Registrar pedido'

    expect(current_url).to eq new_user_session_url
  end

  it 'com sucesso' do
    user = User.create!(email: 'sergio@email.com', password: '12345678', name: 'Sergio')
    Warehouse.create!(name: 'Galpão Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av do porto, 1000', cep: '20000000', description: 'Galpão do rio')
    warehouse = Warehouse.create!(name: 'Galpão Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Atlântica, 50', cep: '80000000', description: 'Perto do Aeroporto')
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '46734987640198', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
    supplier = Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '37856483027154', full_address: 'Torre da Industria, 38', city: 'Teresina', state: 'PI', email: 'venda@spark.com')
    
    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('ABCDE12345')
    login_as(user)
    visit root_path
    click_on 'Registrar pedido'
    select 'MCZ - Galpão Maceio', from: 'Galpão destino'
    select 'Spark Industries Brasil LTDA - CNPJ: 37.856.483/0271-54', from: 'Fornecedor'
    fill_in 'Data prevista de entrega', with: '20/12/2022'
    click_on 'Gravar'

    expect(page).to have_content 'Pedido registrado com sucesso'
    expect(page).to have_content 'Pedido ABCDE12345'
    expect(page).to have_content 'Galpão destino: MCZ - Galpão Maceio'  
    expect(page).to have_content 'Fornecedor: Spark Industries Brasil LTDA - CNPJ: 37.856.483/0271-54'
    expect(page).to have_content 'Data prevista de entrega: 20/12/2022'
    expect(page).to have_content 'Usuário Responsável: Sergio - sergio@email.com'
    expect(page).to have_content 'Situação do Pedido: Pendente'
    expect(page). not_to have_content 'ACME LTDA'
    expect(page). not_to have_content 'Galpão Rio'
  end

  it 'com data inválida' do 
    user = User.create!(email: 'sergio@email.com', password: '12345678', name: 'Sergio')
    warehouse = Warehouse.create!(name: 'Galpão Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Atlântica, 50', cep: '80000000', description: 'Perto do Aeroporto')
    supplier = Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '37856483027154', full_address: 'Torre da Industria, 38', city: 'Teresina', state: 'PI', email: 'venda@spark.com')
    
    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('ABCDE12345')
    login_as(user)
    visit root_path
    click_on 'Registrar pedido'
    select 'MCZ - Galpão Maceio', from: 'Galpão destino'
    select 'Spark Industries Brasil LTDA - CNPJ: 37.856.483/0271-54', from: 'Fornecedor'
    fill_in 'Data prevista de entrega', with: '01/01/2022'
    click_on 'Gravar'

    expect(page).to have_content 'Data prevista de entrega deve estar no futuro.'
  end

  it 'e não informa data de entrega' do 
    user = User.create!(email: 'sergio@email.com', password: '12345678', name: 'Sergio')
    warehouse = Warehouse.create!(name: 'Galpão Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Atlântica, 50', cep: '80000000', description: 'Perto do Aeroporto')
    supplier = Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '37856483027154', full_address: 'Torre da Industria, 38', city: 'Teresina', state: 'PI', email: 'venda@spark.com')
    
    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('ABCDE12345')
    login_as(user)
    visit root_path
    click_on 'Registrar pedido'
    select 'MCZ - Galpão Maceio', from: 'Galpão destino'
    select 'Spark Industries Brasil LTDA - CNPJ: 37.856.483/0271-54', from: 'Fornecedor'
    fill_in 'Data prevista de entrega', with: ''
    click_on 'Gravar'

    expect(page).to have_content 'Não foi possível resgistrar o pedido.'
    expect(page).to have_content 'Data prevista de entrega não pode ficar em branco'

  end
end