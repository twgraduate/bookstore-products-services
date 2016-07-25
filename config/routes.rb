Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "bookstore-products-services/version" => "versions#index"
  get    'books'          => "books#index"
  post   'books'          => "books#create"
  # get    'books/:isbn'      => "books#show"
  put    'books/:isbn'    => "books#update"
  # delete 'books/:isbn'      => "books#destroy"
  # get    'books/new'        => "books#new"
  # get    'books/:isbn/edit' => "books#edit"
end
