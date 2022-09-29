require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do 
  context 'presença' do 
    it 'nome é obrigatório' do 
      user = User.new(email: 'joao@email.com', password: 'password', name: '')

      expect(user.valid?).to eq false
    end
  end
  end
end
