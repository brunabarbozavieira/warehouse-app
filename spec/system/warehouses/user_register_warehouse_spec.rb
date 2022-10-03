require 'rails_helper'

describe 'Usuário cadastra um galpão' do 
  it 'e deve estar autenticado' do 
    visit new_warehouse_url
  
    expect(current_url).to eq new_user_session_url
  end
  
  it 'a partir da tela inicial' do 
    user = User.create!(email: 'joao@email.com', password: 'password', name: 'João')

    login_as(user)
    visit root_path
    click_on 'Cadastrar Galpão'

    expect(page).to have_field('Nome')
    expect(page).to have_field('Descrição')
    expect(page).to have_field('Código')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('CEP')
    expect(page).to have_field('Área')
  end

  it 'com sucesso' do 
    user = User.create!(email: 'joao@email.com', password: 'password', name: 'João')

    login_as(user)
    visit root_path
    click_on 'Cadastrar Galpão'
    fill_in 'Nome', with: 'Rio de Janeiro'
    fill_in 'Descrição', with: 'Galpão da zona portuária do Rio'
    fill_in 'Código', with: 'RIO'
    fill_in 'Cidade', with: 'Rio de Janeiro'
    fill_in 'Endereço', with: 'Avenida do museu do amanhã, 1000'
    fill_in 'CEP', with: '20100000'
    fill_in 'Área', with: '32000'
    click_on 'Criar Galpão'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão cadastrado com sucesso.'
    expect(page).to have_content 'Rio de Janeiro'
    expect(page).to have_content 'RIO'
    expect(page).to have_content '32000 m²'
  end

  it 'com dados incompletos' do 
    user = User.create!(email: 'joao@email.com', password: 'password', name: 'João')

    login_as(user)
    visit root_path
    click_on 'Cadastrar Galpão'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Código', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'CEP', with: ''
    fill_in 'Área', with: ''
    click_on 'Criar Galpão'

    expect(page).to have_content 'Galpão não cadastrado.'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Código não pode ficar em branco'
    expect(page).to have_content 'Cidade não pode ficar em branco'
    expect(page).to have_content 'Endereço não pode ficar em branco'
    expect(page).to have_content 'CEP não pode ficar em branco'
    expect(page).to have_content 'Área não pode ficar em branco'

  end
end