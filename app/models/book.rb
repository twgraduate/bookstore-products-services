class Book < ApplicationRecord

  #stastic rules
  validates :name,  :presence => { :message => "Book name can't be empty" } ,
                    :uniqueness => {:scope =>:author, :message => "Name&&author of two books can't be the same at the same time" }
  validates :author, :presence => {:message => "Author can't be empty"}

  validates :isbn,  :presence =>{:message => "Isbn name can't be empty"},
      :uniqueness => {:message => "Isbn should be unique"}

end
