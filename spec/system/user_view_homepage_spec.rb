require 'rails_helper'

describe 'Usuário visita a tela inicial' do 
  it 'e deve estar autenticado' do 
    visit root_path
  
    expect(current_url).to eq new_user_session_url
  end

  it 'e vê o nome da app' do 
    user = User.create!(email: 'joao@email.com', password: 'password', name: 'João')

    login_as(user)
    visit(root_path)
    expect(page).to have_content('Galpões & Estoque')
    expect(page).to have_link('Galpões & Estoque', href: root_path)
  end
end