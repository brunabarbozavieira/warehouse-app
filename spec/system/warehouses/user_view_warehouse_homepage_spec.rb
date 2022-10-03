require 'rails_helper'

describe 'Usuário visita a tela inicial' do 
  it 'e vê os galpões cadastrados' do 
    user = User.create!(email: 'joao@email.com', password: 'password', name: 'João')
    Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av do porto, 1000', cep: '20000000', description: 'Galpão do rio')
    Warehouse.create!(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Atlântica, 50', cep: '80000000', description: 'Perto do Aeroporto')

    login_as(user)
    visit(root_path)

    expect(page).not_to have_content('Não existem galpões cadastrados')
    expect(page).to have_content('Rio')
    expect(page).to have_content('Código: SDU')
    expect(page).to have_content('Cidade: Rio de Janeiro')
    expect(page).to have_content('60000 m²')

    expect(page).to have_content('Maceio')
    expect(page).to have_content('Código: MCZ')
    expect(page).to have_content('Cidade: Maceio')
    expect(page).to have_content('50000 m²')
  end
  
  it 'e não existem galpões cadastrados' do 
    user = User.create!(email: 'joao@email.com', password: 'password', name: 'João')

    login_as(user)
    visit(root_path)

    expect(page).to have_content('Não existem galpões cadastrados')
  end 
end