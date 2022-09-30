require 'rails_helper'

describe 'Usuário vê detalhes do fornecedor' do 
  it 'a partir da tela inicial' do 
    user = User.create!(email: 'joao@email.com', password: 'password', name: 'João')
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '46734987640198', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    login_as(user)
    visit root_path
    within 'nav' do
      click_on 'Fornecedores'
    end
    click_on 'ACME'

    expect(page).to have_content 'ACME LTDA'
    expect(page).to have_content 'Documento: 46.734.987/6401-98'
    expect(page).to have_content 'Endereço: Av das Palmas, 100 - Bauru - SP'
    expect(page).to have_content 'E-mail: contato@acme.com'
  end

  it 'e volta para tela inicial' do 
    user = User.create!(email: 'joao@email.com', password: 'password', name: 'João')
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '46734987640198', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    login_as(user)
    visit root_path
    within 'nav' do
      click_on 'Fornecedores'
    end
    click_on 'ACME'
    click_on 'Voltar'

    expect(current_url).to eq root_url
  end
end