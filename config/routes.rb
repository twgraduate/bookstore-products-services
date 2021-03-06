Rails.application.routes.draw do
  get 'bookstore-products-services/version' => 'versions#index'
  get    'books'          => 'books#index'
  post   'books'          => 'books#create'
  get    'books/:isbn'    => 'books#show'
  put    'books/:isbn'    => 'books#update'
  delete 'books/:isbn'    => 'books#delete'

end
