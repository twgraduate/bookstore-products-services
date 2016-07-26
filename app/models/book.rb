class Book < ApplicationRecord

  self.primary_key = 'isbn'

  validates :author, :presence => {:message => "Author can't be empty" }

  validates :name, :uniqueness => {:scope =>:author, :message => "Name&&author of two books can't be the same at the same time"},
            :presence => {:message => "Name can't be empty" }
  validates :isbn, :uniqueness => {:message => "Isbn should be unique"},
            :presence => {:message => "Isbn can't be empty" }

end
