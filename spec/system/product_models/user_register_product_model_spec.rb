require 'rails_helper'

describe 'Usuário cadastra um modelo de produto' do 
  it 'com sucesso' do 
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', registration_number: '46734987000198', full_address: 'Av Nações Unidas, 100', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
    other_supplier = Supplier.create!(corporate_name: 'LG do Brasil LTDA', brand_name: 'LG', registration_number: '18776688000150', full_address: 'Av Ibirapuera, 300', city: 'São Paulo', state: 'SP', email: 'contato@lg.com')

    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar Novo'
    fill_in 'Nome', with: 'TV 32'
    fill_in 'Peso', with: 8000
    fill_in 'Altura', with: 45
    fill_in 'Largura', with: 70
    fill_in 'Profundidade', with: 10 
    fill_in 'SKU', with: 'TV32-SAMSU-XPTO90000'
    select 'Samsung', from: 'Fornecedor'
    click_on 'Criar Modelo de Produto'

    expect(page).to have_content 'Modelo de produto cadastrado com sucesso'
    expect(page).to have_content 'Fornecedor: Samsung'
    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'SKU: TV32-SAMSU-XPTO90000'
    expect(page).to have_content 'Dimensão: 45cm x 70cm x 10cm' 
    expect(page).to have_content 'Peso: 8000g'
  end

  it 'com dados incompletos' do 
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', registration_number: '46734987000198', full_address: 'Av Nações Unidas, 100', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')

    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar Novo'
    fill_in 'Nome', with: ''
    fill_in 'Peso', with: ''
    fill_in 'Altura', with: ''
    fill_in 'Largura', with: ''
    fill_in 'Profundidade', with: ''
    fill_in 'SKU', with: ''
    select 'Samsung', from: nil
    click_on 'Criar Modelo de Produto'

    expect(page).to have_content 'Não foi possível cadastrar o modelo de produto.'
  end
end

