require 'rails_helper'

describe 'Usuário remove um galpão' do 
  it 'com sucesso' do 
    w = Warehouse.create!(name: 'Cuiabá', code: 'CWB', city: 'Cuiabá', area: 10_000, address: 'Av das Onças, 200', cep: '54000000', description: 'Galpão de cargas importadas')

    visit root_path
    click_on 'Cuiabá'
    click_on 'Remover'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).not_to have_content 'Cuiabá'
    expect(page).not_to have_content 'CWB'
  end

  it 'e não apaga outros galpões' do 
    first_warehouse = Warehouse.create!(name: 'Cuiabá', code: 'CWB', city: 'Cuiabá', area: 10_000, address: 'Av das Onças, 200', cep: '54000000', description: 'Galpão de cargas importadas')
    second_warehouse = Warehouse.create!(name: 'Belo Horizonte', code: 'BHZ', city: 'Belo Horizonte', area: 20_000, address: 'Av Tiradendes, 880', cep: '46000000', description: 'Galpão para cargas mineiras')

    visit root_path
    click_on 'Cuiabá'
    click_on 'Remover'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).to have_content 'Belo Horizonte'
    expect(page).not_to have_content 'Cuiabá'

  end
end