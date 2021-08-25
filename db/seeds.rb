nil_array = []
10.times { nil_array.push(nil) }
20.times { |n| Author.create!( name: "author_#{n}") }
100.times { |n| Book.create!( title: "title_#{n}", description: "description_#{n}", price: [1900, 2100, 2500, 3000, 3980].sample, author_id: Author.ids.sample) }
100.times { |n| User.create!( name: "name_#{n}", email: "email_#{n}") }
200.times { |n| Review.create!( content: "content_#{n}", user_id: User.ids.sample, book_id: Book.ids.sample ) }
200.times { |n| Question.create!( content: "content_#{n}", user_id: User.ids.sample, book_id: Book.ids.sample) }
