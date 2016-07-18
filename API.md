GET：／books                   read book information, return a list of books
GET：／books／:id              return a book detailed information by book id, return 404 response code when no book found
POST: /books                   add book information to the sql,return 2XX response code, 500 response code for any error ,
PUT /products/{productId}      edit detail information by book id,return 2XX response code, 500 response code for any error,
DELETE /products/{productId}   delete book information by book id,return 2XX response code, 500 response code for any error
