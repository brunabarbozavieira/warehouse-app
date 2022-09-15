require 'rails_helper'

describe 'Usuário visita a tela inicial' do 
    it 'e vê o nome da app' do 
        visit('/')
        expect(page).to have_content('Galpões & Estoque')
    end
end