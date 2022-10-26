require 'rails_helper'

describe 'Warehouse API' do 
  context 'GET/api/v1/warehouses/1' do 
    it 'sucesso' do 
      warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av do porto, 1000', cep: '20000000', description: 'Galpão do rio')

        get "/api/v1/warehouses/#{warehouse.id}"

        expect(response.status).to eq 200
        expect(response.content_type).to include 'application/json'
        json_response = JSON.parse(response.body)
        expect(json_response["name"]).to eq 'Rio'
        expect(json_response["code"]).to eq 'SDU'
        expect(json_response.keys).not_to include 'created_at'
        expect(json_response.keys).not_to include 'updated_at'
    end

    it 'erro se o galpão não for encontrado' do 
      get "/api/v1/warehouses/99999999999"

      expect(response.status).to eq 404
    end
  end
  context 'GET/api/v1/warehouses' do 
    it 'lista todos os galpões ordenados pelo nome' do 
      Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av do porto, 1000', cep: '20000000', description: 'Galpão do rio')
      Warehouse.create!(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Atlântica, 50', cep: '80000000', description: 'Perto do Aeroporto')

      get '/api/v1/warehouses'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response[1]["name"]).to eq 'Rio'
      expect(json_response[0]["name"]).to eq 'Maceio'
    end

    it 'retornar vazio se não houver galpões' do 
      get '/api/v1/warehouses'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end
  end
end