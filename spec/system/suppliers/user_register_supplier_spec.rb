require 'rails_helper'

describe 'Usuário cadastra um fornecedor' do 
  it 'a partir do menu' do
    visit root_path
    within 'nav' do 
      click_on 'Fornecedores'
    end
    click_on 'Cadastrar novo fornecedor'

    expect(page).to have_field 'Nome Fantasia'
    expect(page).to have_field 'Razão Social'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Estado'
    expect(page).to have_field 'E-mail'
  end

  it 'com sucesso' do 
    visit root_path
    within 'nav' do 
      click_on 'Fornecedores'
    end
    click_on 'Cadastrar novo fornecedor'
    fill_in 'Nome Fantasia', with: 'ACME'
    fill_in 'Razão Social', with: 'ACME LTDA'
    fill_in 'CNPJ', with: '46734987640198'
    fill_in 'Endereço', with: 'Av das Palmas, 100'
    fill_in 'Cidade', with: 'Bauru'
    fill_in 'Estado', with: 'SP'
    fill_in 'E-mail', with: 'contato@acme.com'
    click_on 'Criar Fornecedor'

    expect(page).to have_content 'Fornecedor cadastrado com sucesso.'
    expect(page).to have_content 'ACME LTDA'
    expect(page).to have_content 'Documento: 46.734.987/6401-98'
    expect(page).to have_content 'Endereço: Av das Palmas, 100 - Bauru - SP'
    expect(page).to have_content 'E-mail: contato@acme.com'
  end

  it 'com dados incompletos' do 
    visit root_path
    within 'nav' do 
      click_on 'Fornecedores'
    end
    click_on 'Cadastrar novo fornecedor'
    fill_in 'Nome Fantasia', with: ''
    fill_in 'Razão Social', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Estado', with: ''
    fill_in 'E-mail', with: ''
    click_on 'Criar Fornecedor'

    expect(page).to have_content 'Fornecedor não cadastrado.'
    expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
    expect(page).to have_content 'Razão Social não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
  end
end
