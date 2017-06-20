json.extract! book, :id, :name, :content, :slug, :created_at, :updated_at
json.url post_url(book, format: :json)
