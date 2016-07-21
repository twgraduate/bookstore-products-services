class Book < ApplicationRecord

  # #stastic rules
  # validates :name,  :presence => { :message => "Book name can't be empty" } ,
  #                   :uniqueness => {:scope =>:author, :message => "Name&&author of two books can't be the same at the same time"}
  # validates :author, :presence => {:message => "Author can't be empty" }
  #
  # validates :isbn,  :presence =>{:message => "Isbn name can't be empty"},
  #                   :uniqueness => {:message => "Isbn should be unique"}


  def initialize(attributes=nil)
    @name = attributes[:name]
    @isbn = attributes[:isbn]
    @author = attributes[:author]
    @price = attributes[:price]
    @img_url = attributes[:img_url]
    @description = attributes[:description]
  end

  def error_dect
    raise NameError 'Book name can not be empty' if attributes[:name] == nil


  end
end
