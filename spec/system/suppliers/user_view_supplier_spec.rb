require 'rails_helper'

describe 'Usuário acessa página de fornecedores' do 
  it 'a partir do menu' do 
    visit root_path
    within 'nav' do
      click_on 'Fornecedores'
    end

    expect(current_url).to eq suppliers_url
  end

  it 'e vê lista de fornecedores' do
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '46734987640198', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
    Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '37856483027154', full_address: 'Torre da Industria, 38', city: 'Teresina', state: 'PI', email: 'venda@spark.com')

    visit root_path
    within 'nav' do
      click_on 'Fornecedores'
    end

    expect(page).to have_content 'Fornecedores'
    expect(page).to have_content 'ACME'
    expect(page).to have_content 'Bauru - SP'
    expect(page).to have_content 'Spark'
    expect(page).to have_content 'Teresina - PI'
  end

  it 'e não exitem fornecedores cadastrados' do 

    visit root_path
    within 'nav' do
      click_on 'Fornecedores'
    end

    expect(page).to have_content 'Não existem fornecedores cadastrados.'

  end
end