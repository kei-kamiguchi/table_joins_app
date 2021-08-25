## サンプルアプリのテーブル構造
[![Image from Gyazo](https://t.gyazo.com/teams/diveintocode/4cc6ee847b174f22207ca8acbe87655b.png)](https://diveintocode.gyazo.com/4cc6ee847b174f22207ca8acbe87655b)

## テーブル結合の基本
- 以下のアソシエーションが組まれていることが前提です。アソシエーションが組まれていなければ、joinsなどの結合メソッドは使用できません。

[app/models/author.rb]
```rb
class Author < ApplicationRecord
  has_many :books
end
```
[app/models/book.rb]
```rb
class Book < ApplicationRecord
  belongs_to :author
  has_many :reviews
  has_many :questions
end
```
[app/models/review.rb]
```rb
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :book
end
```
[app/models/question.rb]
```rb
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :book
end
```
[app/models/user.rb]
```rb
class User < ApplicationRecord
  has_many :reviews
  has_many :questions
end
```
#### 1. 内部結合
```
$ Book.joins(:reviews)
```
- 本とレビューコメントを内部結合する
- book_idがnilのコメントは返されない
- データの数はレビューコメント数と同じになる
[以下の結合テーブルをBookオブジェクトとして取得]

|id|title|description|price|author_id|content（レビューコメント情報）|
|--|--|--|--|--|--|

#### 2. 外部結合
[例]
```
$ Book.left_outer_joins(:reviews)
```
- 取得する結合テーブルの数は「レビューコメント数」+「コメントの無い本の数」

#### 3. 2テーブル結合
[例]
```
$ Book.joins(:reviews, :questions)
$ Book.joins(:author, :reviews)
```
### 

[例]
```
$ Author.joins(books: :reviews)
```
