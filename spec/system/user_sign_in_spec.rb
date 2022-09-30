require 'rails_helper'

describe 'Usuário se autentica' do 
  it 'com sucesso' do 
    User.create!(email: 'joao@email.com', password: 'password', name: 'João')

    visit new_user_session_url
    within 'form' do 
      fill_in 'E-mail', with: 'joao@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    
    within 'nav' do 
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'joao@email.com'
    end
    expect(page).to have_content 'Login efetuado com sucesso'
  end

  it 'e faz logout' do 
    User.create!(email: 'joao@email.com', password: 'password', name: 'João')

    visit new_user_session_url
    within 'form' do 
      fill_in 'E-mail', with: 'joao@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    click_on 'Sair'

    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_button 'Sair'
    expect(page).not_to have_content 'joao@email.com'

  end
end