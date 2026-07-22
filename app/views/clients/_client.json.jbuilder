json.extract! client, :id, :name, :email, :created_at, :updated_at
json.url client_url(client, format: :json)
