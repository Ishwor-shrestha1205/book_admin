# README

Let's create simple book_admin web app with Rails.

- For creating new app

```
rails new book_admin \
> --skip-action-mailer \
> --skip-action-mailbox \
> -skip-action-text \
> --skip-action-text \
> --skip-action-storage \
> --skip-action-cable
```

For creating model

```
bin/rails g model Book \
> name:string \
> published_on:date \
> price:integer
```

Migrating

```
bin/rails db:create
bin/rails db:migrate
```

Inserting dummy data through console

```
bin/rails c
Running via Spring preloader in process 46176
Loading development environment (Rails 6.1.4.3)
>> Book.new
   (2.2ms)  SELECT sqlite_version(*)
=> #<Book id: nil, name: nil, published_on: nil, price: nil, created_at: nil, updated_at: nil>
>> Book
=> Book(id: integer, name: string, published_on: date, price: integer, created_at: datetime, updated_at: datetime)
>> (1..5).each do |i|
?> Book.create(
?> name: "Book #{i}",
?> published_on: Time.parse("20191224").ago(i.months),
?> price: (i * 1000),
?> )
>> end
```

Adding Tables Publisher and Author

```
bin/rails g model Publisher name:string address:text
bin/rails g model Author name:string penname:string
bin/rails db:migrate
```

For making relation of Publisher and Book, create new model

```
bin/rails g migration AddPublisherIdToBooks publisher:references
bin/rails db:reset
bin/rails db:migrate
```

Using console insert data in Publisher and Book

```
>> publisher = Publisher.create(
?> name: "Gihyo inc.",
?> address: "Ichigaya",
?> )
>> publisher.books << Book.create(
?> name: "Book 1",
?> published_on: Time.current,
?> price: 1000,
?> )
>> publisher.books << Book.create(
?> name: "Book 2",
?> published_on: Time.current,
?> price: 2000,
?> )
>> publisher.books.to_a
>> book = Book.find(1)
>> book.publisher.name
```
