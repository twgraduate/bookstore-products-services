Rails.application.routes.draw do
  resources :books
  resources :versions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "bookstore-products-services/version" => "versions#index"
end
