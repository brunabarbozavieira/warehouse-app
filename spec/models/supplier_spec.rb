require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do 
  context 'presença' do
    it 'falso quando nome fantasia está vazio' do
      supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: '', registration_number: '46734987640198', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

      expect(supplier.valid?).to eq false
    end

    it 'falso quando razão social está vazio' do
      supplier = Supplier.new(corporate_name: '', brand_name: 'ACME', registration_number: '46734987640198', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

      expect(supplier.valid?).to eq false
    end

    it 'falso quando CNPJ está vazio' do
      supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

      expect(supplier.valid?).to eq false
    end

  end

  context 'singularidade' do 
    it 'falso quando CNPJ já está em uso' do 
      first_supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '46734987640198', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
      second_supplier = Supplier.new(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '46734987640198', full_address: 'Torre da Industria, 38', city: 'Teresina', state: 'PI', email: 'venda@spark.com')

      expect(second_supplier.valid?).to eq false
    end
  end

  context 'comprimento' do 
    it 'falso quando CNPJ for maior que 14 caracteres' do 
      supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '467349876401980', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

      expect(supplier.valid?).to eq false
    end

    it 'falso quando CNPJ for menor que 14 caracteres' do 
      supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '4673498764019', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

      expect(supplier.valid?).to eq false
    end
  end

  context 'apenas números' do 
    it 'falso quando CNPJ for diferente de número' do
      supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: 'abcdefghijklmn', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

      expect(supplier.valid?).to eq false
    end
  end
end

  describe '#description' do 
    it 'exibe razão social e CNPJ' do 
      s = Supplier.new(corporate_name: 'Spark Industries Brasil LTDA', registration_number: '37856483027154')

      expect(s.description).to eq 'Spark Industries Brasil LTDA - CNPJ: 37.856.483/0271-54'
    end
  end
end
