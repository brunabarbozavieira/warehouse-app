require 'rails_helper'

describe 'Usuário visita a tela inicial' do 
  it 'e vê o nome da app' do 
    user = User.create!(email: 'joao@email.com', password: 'password', name: 'João')

    login_as(user)
    visit(root_path)
    expect(page).to have_content('Galpões & Estoque')
  end
end