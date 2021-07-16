json.extract! user, :id, :name, :email, :created_at, :updated_at,:image,:password_digest
json.url user_url(user, format: :json)
