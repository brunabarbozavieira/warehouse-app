require 'rails_helper'

describe 'Usuário edita um fornecedor' do 
  it 'a partir da página de detalhes' do
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '46734987640198', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    visit root_path
    within 'nav' do
      click_on 'Fornecedores'
    end
    click_on 'ACME'
    click_on 'Editar'

    expect(page).to have_content 'Editar Fornecedor'
    expect(page).to have_field 'Nome Fantasia', with: 'ACME'
    expect(page).to have_field 'Razão Social', with: 'ACME LTDA'
    expect(page).to have_field 'CNPJ', with: '46734987640198'
    expect(page).to have_field 'Endereço', with: 'Av das Palmas, 100'
    expect(page).to have_field 'Cidade', with: 'Bauru'
    expect(page).to have_field 'Estado', with: 'SP'
    expect(page).to have_field 'E-mail', with: 'contato@acme.com'
  end

  it 'com sucesso' do 
    Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '37856483027154', full_address: 'Torre da Industria, 38', city: 'Teresina', state: 'PI', email: 'venda@spark.com')

    visit root_path
    within 'nav' do
      click_on 'Fornecedores'
    end
    click_on 'Spark'
    click_on 'Editar'
    fill_in 'Nome Fantasia', with: 'ACME'
    fill_in 'Razão Social', with: 'ACME LTDA'
    fill_in 'CNPJ', with: '46734987640198'
    fill_in 'Endereço', with: 'Av das Palmas, 100'
    fill_in 'Cidade', with: 'Bauru'
    fill_in 'Estado', with: 'SP'
    fill_in 'E-mail', with: 'contato@acme.com'
    click_on 'Atualizar Fornecedor'

    expect(page).to have_content 'Fornecedor atualizado com sucesso.'
    expect(page).to have_content 'ACME LTDA'
    expect(page).to have_content 'Documento: 46.734.987/6401-98'
    expect(page).to have_content 'Endereço: Av das Palmas, 100 - Bauru - SP'
    expect(page).to have_content 'E-mail: contato@acme.com'
  end

  it 'e matém os campos obrigatórios' do 
    Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '37856483027154', full_address: 'Torre da Industria, 38', city: 'Teresina', state: 'PI', email: 'venda@spark.com')

    visit root_path
    within 'nav' do
      click_on 'Fornecedores'
    end
    click_on 'Spark'
    click_on 'Editar'
    fill_in 'Nome Fantasia', with: ''
    fill_in 'Razão Social', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: 'Av das Palmas, 100'
    fill_in 'Cidade', with: 'Bauru'
    fill_in 'Estado', with: 'SP'
    fill_in 'E-mail', with: 'contato@acme.com'
    click_on 'Atualizar Fornecedor'

    expect(page).to have_content 'Não foi possível atualizar o fornecedor.'
  end
end

