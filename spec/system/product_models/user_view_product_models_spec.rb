require 'rails_helper'

describe 'Usuário vê modelos de produtos' do 

  it 'se estive autenticado' do 
    visit root_path
    within 'nav' do 
      click_on 'Modelos de Produtos'
    end

    expect(current_url).to eq new_user_session_url
  end

  it 'a partir do menu' do 
    user = User.create!(email: 'joao@email.com', password: 'password', name: 'João')
    login_as(user)

    visit root_path
    within 'nav' do 
      click_on 'Modelos de Produtos'
    end 

    expect(current_url).to eq product_models_url
  end

  it 'com sucesso' do 
    user = User.create!(email: 'joao@email.com', password: 'password', name: 'João')
    
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', registration_number: '46734987000198', full_address: 'Av Nações Unidas, 100', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
    ProductModel.create!(name: 'TV 32', weigth: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
    ProductModel.create!(name: 'SoundBar 7.1 Surroud', weigth: 3000, width: 80, height: 15, depth: 20, sku: 'SOU71-SAMSU-NOIZ7700', supplier: supplier)

    login_as(user)
    visit root_path
    within 'nav' do 
      click_on 'Modelos de Produtos'
    end

    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'TV32-SAMSU-XPTO90000'
    expect(page).to have_content 'Samsung'
    expect(page).to have_content 'SoundBar 7.1 Surroud'
    expect(page).to have_content 'SOU71-SAMSU-NOIZ7700'
    expect(page).to have_content 'Samsung'
  end

  it 'e não existem produtos cadastrados' do 
    user = User.create!(email: 'joao@email.com', password: 'password', name: 'João')

    login_as(user)
    visit root_path
    within 'nav' do 
      click_on 'Modelos de Produtos'
    end

    expect(page).to have_content 'Nenhum modelo de produto cadastrado.'
  end
end