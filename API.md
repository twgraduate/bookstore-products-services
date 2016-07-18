API Basic
    Get all books information list:                  GET     /books
    Read a book detailed information by book i       GET     /books/:id
    Add a book to the list                           POST    /book
    Edit detail information by book id               PUT     /book/:id
    Delete book information by book id               DELETE  /book/:id


API error
    When an error occured, HTTP Status Code is 404,422,500.
    Layout of error:
    {
        'msg':'error message'
    }
    404:  Book not found;
    422:  Some parameters are illegal, book entity is unprocessable;
    500:  other error

    Error Message                   Status Code             Error describe
    Book not found                      404             {:id} don't refers to any book
    Exception                           500             Other error
    Book name can't be empty            422             The book name in your parameters is empty
    Name&&author of two books……         422             The book you POST or PUT has the same name and author with books in SQL
    Author can't be empty               422             The book author in your parameters is empty
    Isbn can't be empty            422             The book isbn in your parameters is empty
    Isbn should be unique               422             The book you POST or PUT has the same ISBN with other books in SQL




Get books list
    GET localhost:3000/books
    Return books list, status=200
        {
            "id": 1,
            "name": "Rails之道",
            "isbn": "4727011",
             ………………
          },
          {
            "id": 2,
            "name": "Programming Ruby中文版",
            "isbn": "2032343",
             ………………
          },
          {
            "id": 3,
            "name": "Ruby编程语言",
            "isbn": "3329887",
             ………………
          },
          ……


Get a book message
    GET localhost:3000/books/:id
    Return a book's information,status=200
      {
        "id": 2,
        "name": "Programming Ruby中文版",
        "isbn": "2032343",
        "author": "托马斯",
        "price": 99,
        "img_url": "https://img3.doubanio.com/mpic/s2370875.jpg",
        "description": "《Programming Rudy》(中文版)(第2版)是……"
      }

Post a new book
    POST localhost:3000/books
    Create a new book, status=201
    Parameters information:
        {
           book[name]:Rail之道
           book[isbn]:4727011
           book[author]:(美)Obie Fernandez
           book[price]:89
           book[img_url]:https://img3.doubanio.com/mpic/s4282672.jpg
           book[description]:《Rails之道》按照Rails的各...
        }


Edit a book
    PUT localhost:3000/books/:id
    Edit a book, status=202

Destroy a book
    DELETE localhost:3000/books/:id
    Delete a book, status=200













GET：／books                   read book information, return a list of books
GET：／books／:id              return a book detailed information by book id, return 404 response code when no book found
POST: /books                   add book information to the sql,return 2XX response code, 500 response code for any error ,
                               (for example)
                               book[name]:Rail之道
                               book[isbn]:4727011
                               book[author]:(美)Obie Fernandez
                               book[price]:89
                               book[img_url]:https://img3.doubanio.com/mpic/s4282672.jpg
                               book[description]:《Rails之道》按照Rails的各...
PUT /products/{productId}      edit detail information by book id,return 2XX response code, 500 response code for any error,
DELETE /products/{productId}   delete book information by book id,return 2XX response code, 500 response code for any error

:name, :isbn, :author can't be empty;
a book can't have the same name and author at the same time.
