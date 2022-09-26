require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do 
  context 'presença' do 
    it 'falso quando nome está vazio' do 
      warehouse = Warehouse.new(name:'', code:'RIO', city:'Rio de Janeiro', area:'40_000', 
                                address:'Avenida Principal', cep:'25000000', description:'Galpão de uso internacional')

      expect(warehouse.valid?).to eq false
    end

    it 'falso quando código está vazio' do 

      warehouse = Warehouse.new(name:'Galpão do Rio', code:'', city:'Rio de Janeiro', area:'40_000', 
                                address:'Avenida Principal', cep:'25000000', description:'Galpão de uso internacional')

      expect(warehouse.valid?).to eq false
    end

    it 'falso quando cidade está vazio' do 

      warehouse = Warehouse.new(name:'Galpão do Rio', code:'RIO', city:'', area:'40_000', 
                                address:'Avenida Principal', cep:'25000000', description:'Galpão de uso internacional')

      expect(warehouse.valid?).to eq false
    end

    it 'falso quando área está vazio' do 

      warehouse = Warehouse.new(name:'Galpão do Rio', code:'RIO', city:'Rio de Janeiro', area:'', 
                                address:'Avenida Principal', cep:'25000000', description:'Galpão de uso internacional')

      expect(warehouse.valid?).to eq false
    end

    it 'falso quando endereço está vazio' do 

      warehouse = Warehouse.new(name:'Galpão do Rio', code:'RIO', city:'Rio de Janeiro', area:'40_000', 
                                address:'', cep:'25000000', description:'Galpão de uso internacional')

      expect(warehouse.valid?).to eq false
    end

    it 'falso quando cep está vazio' do 

      warehouse = Warehouse.new(name:'Galpão do Rio', code:'RIO', city:'Rio de Janeiro', area:'40_000', 
                                address:'Avenida Principal', cep:'', description:'Galpão de uso internacional')

      expect(warehouse.valid?).to eq false
    end

    it 'falso quando descrição está vazio' do 

      warehouse = Warehouse.new(name:'Galpão do Rio', code:'RIO', city:'Rio de Janeiro', area:'40_000', 
                              address:'Avenida Principal', cep:'25000000', description:'')

      expect(warehouse.valid?).to eq false
    end
  end
  context 'singularidade' do 
    it 'falso quando o código já está em uso' do 
      first_warehouse = Warehouse.create!(name:'Galpão do Rio', code:'RIO', city:'Rio de Janeiro', area:'40_000', 
                                         address:'Avenida Principal', cep:'25000000', description:'Galpão de uso internacional')
      second_warehouse = Warehouse.new(name:'Galpão Manaus', code:'RIO', city:'Manaus', area:'60_000', 
                                          address:'Rua dos Aviões', cep:'45000000', description:'Galpão da Zona Franca')

      expect(second_warehouse.valid?).to eq false
    end

    it 'falso quando o nome já está em uso' do 
      first_warehouse = Warehouse.create!(name:'Galpão do Rio', code:'RIO', city:'Rio de Janeiro', area:'40_000', 
                                        address:'Avenida Principal', cep:'25000000', description:'Galpão de uso internacional')
      second_warehouse = Warehouse.new(name:'Galpão do Rio', code:'MAO', city:'Manaus', area:'60_000', 
                                        address:'Rua dos Aviões', cep:'45000000', description:'Galpão da Zona Franca')

      expect(second_warehouse.valid?).to eq false
    end
  end
  context 'comprimento' do 
    it 'falso quando cep for maior que oito caracteres' do

      warehouse = Warehouse.new(name:'Galpão do Rio', code:'RIO', city:'Rio de Janeiro', area:'40_000', 
                                address:'Avenida Principal', cep:'250000000', description:'Galpão de uso internacional')

      expect(warehouse.valid?).to eq false
    end

    it 'falso quando cep for menor que oito caracteres' do

      warehouse = Warehouse.new(name:'Galpão do Rio', code:'RIO', city:'Rio de Janeiro', area:'40_000', 
                                address:'Avenida Principal', cep:'2500000', description:'Galpão de uso internacional')

      expect(warehouse.valid?).to eq false
    end
  end
  context 'apenas números' do
    it 'falso quando cep for diferente de número' do 

      warehouse = Warehouse.new(name:'Galpão do Rio', code:'RIO', city:'Rio de Janeiro', area:'40_000', 
                                address:'Avenida Principal', cep:'abcdefgh', description:'Galpão de uso internacional')

      expect(warehouse.valid?).to eq false

    end
  end
  end
end
