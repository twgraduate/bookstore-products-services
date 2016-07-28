# Read about factories at https://github.com/thoughtbot/factory_girl
# #
FactoryGirl.define do
  factory :book do
    name     'A name'   # {Faker::Name.name}
    isbn     'ga'                   #{Faker::Isbn.isbn}
    author   'An author'                 #{Faker::Author.author}
    price    13                     #{Faker::Price.price}
    img_url  'An url'    #{Faker::Img_url.img_url}
    description  'A description'             #{Faker::Description.description}
  end
end