require 'rails_helper'

describe 'Usuário vê detalhes de um galpão' do 
  it 'e deve estar autenticado' do 
    visit warehouse_url(1)
  
    expect(current_url).to eq new_user_session_url
  end

  it 'e vê informações adicionais' do 
    user = User.create!(email: 'joao@email.com', password: 'password', name: 'João')
    Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                     address: 'Avenida do Aeroporto, 1000', cep:'15000000', 
                     description: 'Galpão destinado para cargas internacionais')

    login_as(user)
    visit(root_path)
    click_on('Aeroporto SP')

    expect(page).to have_content('Galpão GRU')
    expect(page).to have_content('Aeroporto SP')
    expect(page).to have_content('Cidade: Guarulhos')
    expect(page).to have_content('Área: 100000 m²')
    expect(page).to have_content('Endereço: Avenida do Aeroporto, 1000 CEP: 15000-000')
    expect(page).to have_content('Galpão destinado para cargas internacionais')
  end

  it 'e volta para a tela inicial' do 
    user = User.create!(email: 'joao@email.com', password: 'password', name: 'João')
    Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                     address: 'Avenida do Aeroporto, 1000', cep:'15000000', 
                     description: 'Galpão destinado para cargas internacionais')
    login_as(user)
    visit(root_path)
    click_on('Aeroporto SP')
    click_on('Voltar')

    expect(current_url).to eq(root_url)
  end
end