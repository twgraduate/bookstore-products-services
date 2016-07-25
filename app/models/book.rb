class Book < ApplicationRecord

# #stastic rules
#   validate :book_validation
#
#   private
#   def book_validation
#     if name == nil
#       errors[:base] << "Name can not be empty"
#     elsif author ==nil
#       errors[:base] << "Author can not be empty"
#     elsif isbn == nil
#       errors[:base] << "Isbn can not be empty"
#
#
#
#     end
#   end

  validates :author, :presence => {:message => "Author can't be empty" }

  validates :name, :uniqueness => {:scope =>:author, :message => "Name&&author of two books can't be the same at the same time"},
            :presence => {:message => "Name can't be empty" }
  validates :isbn, :uniqueness => {:message => "Isbn should be unique"},
            :presence => {:message => "Isbn can't be empty" }

 # def initialize(attributes={})
 #   raise ArgumentError.new 'Book name/isbn/author can not be empty' if attributes[:name] == nil || attributes[:isbn] == nil || attributes[:author] == nil
 #   @name = attributes[:name]
 #   @isbn = attributes[:isbn]
 #   @author = attributes[:author]
 #   @price = attributes[:price]
 #   @img_url = attributes[:img_url]
 #   @description = attributes[:description]
 # end


end
