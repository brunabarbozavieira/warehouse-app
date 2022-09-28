require 'rails_helper'

describe 'Usuário vê modelos de produtos' do 
  it 'na página de detalhes de fornecedor' do 
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', registration_number: '46734987000198', full_address: 'Av Nações Unidas, 100', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
    ProductModel.create!(name: 'TV 32', weigth: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
    ProductModel.create!(name: 'SoundBar 7.1 Surroud', weigth: 3000, width: 80, height: 15, depth: 20, sku: 'SOU71-SAMSU-NOIZ7700', supplier: supplier)

    visit root_path
    click_on 'Fornecedores'
    click_on 'Samsung'

    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'Dimensão: 45cm x 70cm x 10cm'
    expect(page).to have_content 'SKU: TV32-SAMSU-XPTO90000'
    expect(page).to have_content 'SoundBar 7.1 Surroud'
    expect(page).to have_content 'Dimensão: 15cm x 80cm x 20cm'
    expect(page).to have_content 'SKU: SOU71-SAMSU-NOIZ7700'
  end
end