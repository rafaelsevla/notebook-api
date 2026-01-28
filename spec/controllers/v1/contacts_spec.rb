require 'rails_helper'

describe V1::ContactsController, type: :controller do
  it 'request index and return 200 OK' do
    request.accept = 'application/json'
    get :index
    expect(response).to have_http_status(:ok)
  end

  it 'request index and return 406' do
    get :index
    expect(response).to have_http_status(:not_acceptable)
  end

  it 'GET v1/contacts/:id' do
    contact = Contact.first
    kind = Kind.create!(description: "Amigo")
    contact = Contact.create!(
      name: "Contato Teste",
      email: "teste@teste.com",
      kind: kind,
      address_attributes: { street: "Rua Teste", city: "Cidade" }
    )
    request.accept = 'application/json'

    get :show, params: { id: contact.id }

    response_body = JSON.parse(response.body)

    expect(response_body.fetch('data').fetch('id')).to eq(contact.id.to_s)
    expect(response_body.fetch('data').fetch('type')).to eq('contacts')
  end
end
