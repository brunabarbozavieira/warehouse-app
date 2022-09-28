require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  
  describe '#valid?' do 
  context 'presença' do 
    it 'nome é obrigatório' do 
      supplier = Supplier.create!(corporate_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', registration_number: '46734987000198', full_address: 'Av Nações Unidas, 100', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
      pm = ProductModel.new(name: '', weigth: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90', supplier: supplier)

      expect(pm.valid?).to eq false
    end

    it 'sku é obrigatório' do 
      supplier = Supplier.create!(corporate_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', registration_number: '46734987000198', full_address: 'Av Nações Unidas, 100', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
      pm = ProductModel.new(name: 'TV 32', weigth: 8000, width: 70, height: 45, depth: 10, sku: '', supplier: supplier)

      expect(pm.valid?).to eq false
    end

    it 'peso é obrigatório' do 
      supplier = Supplier.create!(corporate_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', registration_number: '46734987000198', full_address: 'Av Nações Unidas, 100', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
      pm = ProductModel.new(name: 'TV 32', weigth: '', width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90', supplier: supplier)

      expect(pm.valid?).to eq false
    end

    it 'largura é obrigatório' do 
      supplier = Supplier.create!(corporate_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', registration_number: '46734987000198', full_address: 'Av Nações Unidas, 100', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
      pm = ProductModel.new(name: 'TV 32', weigth: 8000, width: '', height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90', supplier: supplier)

      expect(pm.valid?).to eq false
    end

    it 'altura é obrigatório' do 
      supplier = Supplier.create!(corporate_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', registration_number: '46734987000198', full_address: 'Av Nações Unidas, 100', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
      pm = ProductModel.new(name: 'TV 32', weigth: 8000, width: 70, height: '', depth: 10, sku: 'TV32-SAMSU-XPTO90', supplier: supplier)

      expect(pm.valid?).to eq false
    end

    it 'profundidade é obrigatório' do 
      supplier = Supplier.create!(corporate_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', registration_number: '46734987000198', full_address: 'Av Nações Unidas, 100', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
      pm = ProductModel.new(name: 'TV 32', weigth: 8000, width: 70, height: 45, depth: '', sku: 'TV32-SAMSU-XPTO90', supplier: supplier)

      expect(pm.valid?).to eq false
    end

    it 'fornecedor é obrigatório' do 
      pm = ProductModel.new(name: 'TV 32', weigth: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90', supplier: nil)

      expect(pm.valid?).to eq false
    end
  end

    context 'singularidade' do 
      it 'sku tem que ser único' do 
        supplier = Supplier.create!(corporate_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', registration_number: '46734987000198', full_address: 'Av Nações Unidas, 100', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
        first_pm = ProductModel.create!(name: 'TV 32', weigth: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
        second_pm = ProductModel.new(name: 'SoundBar 7.1 Surroud', weigth: 3000, width: 80, height: 15, depth: 20, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)

        expect(second_pm.valid?).to eq false
      end
    end

    context 'comprimento' do 
      it 'sku não pode ser menor que 20 caracteres' do 
        supplier = Supplier.create!(corporate_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', registration_number: '46734987000198', full_address: 'Av Nações Unidas, 100', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
        pm = ProductModel.new(name: 'TV 32', weigth: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO9000', supplier: supplier)

      expect(pm.valid?).to eq false
      end

      it 'sku não pode ser maior que 20 caracteres' do 
        supplier = Supplier.create!(corporate_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', registration_number: '46734987000198', full_address: 'Av Nações Unidas, 100', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
        pm = ProductModel.new(name: 'TV 32', weigth: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO900000', supplier: supplier)

      expect(pm.valid?).to eq false
      end
    end
    context 'comparação' do 
      it 'peso não pode ser igual a zero' do 
        supplier = Supplier.create!(corporate_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', registration_number: '46734987000198', full_address: 'Av Nações Unidas, 100', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
        pm = ProductModel.new(name: 'TV 32', weigth: 0, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)

        expect(pm.valid?).to eq false
      end

      it 'peso não pode ser menor que zero' do 
        supplier = Supplier.create!(corporate_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', registration_number: '46734987000198', full_address: 'Av Nações Unidas, 100', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
        pm = ProductModel.new(name: 'TV 32', weigth: -1, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)

        expect(pm.valid?).to eq false
      end

      it 'largura não pode ser igual a zero' do 
        supplier = Supplier.create!(corporate_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', registration_number: '46734987000198', full_address: 'Av Nações Unidas, 100', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
        pm = ProductModel.new(name: 'TV 32', weigth: 8000, width: 0, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)

        expect(pm.valid?).to eq false
      end

      it 'largura não pode ser menor que zero' do 
        supplier = Supplier.create!(corporate_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', registration_number: '46734987000198', full_address: 'Av Nações Unidas, 100', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
        pm = ProductModel.new(name: 'TV 32', weigth: 8000, width: -1, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)

        expect(pm.valid?).to eq false
      end

      it 'altura não pode ser igual a zero' do 
        supplier = Supplier.create!(corporate_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', registration_number: '46734987000198', full_address: 'Av Nações Unidas, 100', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
        pm = ProductModel.new(name: 'TV 32', weigth: 8000, width: 70, height: 0, depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)

        expect(pm.valid?).to eq false
      end

      it 'altura não pode ser menor que zero' do 
        supplier = Supplier.create!(corporate_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', registration_number: '46734987000198', full_address: 'Av Nações Unidas, 100', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
        pm = ProductModel.new(name: 'TV 32', weigth: 8000, width: 70, height: -1, depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)

        expect(pm.valid?).to eq false
      end

      it 'profundidade não pode ser igual a zero' do 
        supplier = Supplier.create!(corporate_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', registration_number: '46734987000198', full_address: 'Av Nações Unidas, 100', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
        pm = ProductModel.new(name: 'TV 32', weigth: 8000, width: 70, height: 45, depth: 0, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)

        expect(pm.valid?).to eq false
      end

      it 'profundidade não pode ser menor que zero' do 
        supplier = Supplier.create!(corporate_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', registration_number: '46734987000198', full_address: 'Av Nações Unidas, 100', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
        pm = ProductModel.new(name: 'TV 32', weigth: 8000, width: 70, height: 45, depth: -1, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)

        expect(pm.valid?).to eq false
      end
    end
  end
end
