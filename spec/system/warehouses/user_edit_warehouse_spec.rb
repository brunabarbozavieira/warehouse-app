require 'rails_helper'

describe 'Usuário edita um galpão' do 
  it 'a partir da página de detalhes' do 
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av do porto, 1000', cep: '20000000', description: 'Galpão do rio')

    visit root_path
    click_on 'Rio'
    click_on 'Editar'

    expect(page).to have_content 'Editar Galpão'
    expect(page).to have_field('Nome', with: 'Rio')
    expect(page).to have_field('Código', with: 'SDU')
    expect(page).to have_field('Cidade', with: 'Rio de Janeiro')
    expect(page).to have_field('Área', with: '60000')
    expect(page).to have_field('Endereço', with: 'Av do porto, 1000')
    expect(page).to have_field('CEP', with: '20000000')
    expect(page).to have_field('Descrição', with: 'Galpão do rio')
  end

  it 'com sucesso' do 
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av do porto, 1000', cep: '20000000', description: 'Galpão do rio')

    visit root_path
    click_on 'Rio'
    click_on 'Editar'
    fill_in 'Nome', with: 'Aeroporto SP'
    fill_in 'Código', with: 'GRU'
    fill_in 'Cidade', with: 'Guarulhos'
    fill_in 'Área', with: '100000'
    fill_in 'Endereço', with: 'Avenida do Aeroporto, 500'
    fill_in 'CEP', with: '15000000'
    fill_in 'Descrição', with: 'Galpão destinado para cargas internacionais'
    click_on 'Atualizar Galpão'

    expect(page).to have_content 'Galpão atualizado com sucesso'
    expect(page).to have_content 'Nome: Aeroporto SP'
    expect(page).to have_content 'Cidade: Guarulhos'
    expect(page).to have_content 'Área: 100000 m²'
    expect(page).to have_content 'Endereço: Avenida do Aeroporto, 500 CEP: 15000-000'
  end

  it 'e mantém os campos obrigatórios' do 
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av do porto, 1000', cep: '20000000', description: 'Galpão do rio')

    visit root_path
    click_on 'Rio'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Área', with: ''
    click_on 'Atualizar Galpão'

    expect(page).to have_content 'Não foi possível atualizar o galpão.'
  end
end