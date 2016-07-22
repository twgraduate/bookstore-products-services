module BooksHelper

  def self.add(book)
    book.save
  end
end
