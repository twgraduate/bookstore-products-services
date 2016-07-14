json.array!(@books) do |book|
  json.extract! book, :id, :name, :isbn, :author, :price, :img_url, :description
  json.url book_url(book, format: :json)
end
