class Book < ApplicationRecord

  self.primary_key = 'isbn'

  validates :author, :presence => {:message => "Author can not be empty" }

  validates :name, :uniqueness => {:scope =>:author, :message => "Name&&author of two books can not be all the same"},
            :presence => {:message => "Name can not be empty" }
  validates :isbn, :uniqueness => {:message => "Isbn should be unique"},
            :presence => {:message => "Isbn can not be empty" }
  validates :price, :numericality => {:message => "Price should be a number"}

end
