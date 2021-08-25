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
- Bookとアソシエーションしているテーブルいれば自由に連結できる。
- 結合先のテーブルが、結合元から見てhas_manyであれば複数形、belongs_toであれば単数系で指定。
- 内部結合のため、reviewの無いbookは返さない
- 返されるデータ数はレビューコメント数と同じになる

**結合するメリット**
- 上の例のように、reviewのあるBookオブジェクトを返せる
- Book.reviewsでReviewオブジェクトを返されてしまう

#### 2. 外部結合
[例]
```
$ Book.left_outer_joins(:reviews)
```
- 外部結合のため、reviewがないbookも返される。
- 取得する結合テーブルの数は「review数」+「reviewの無い本の数」

#### 3. 2テーブル結合
[例]
```
# 例1
$ Book.joins(:reviews, :questions)
# 例2
$ Book.joins(:author, :reviews)
```
- 例1：reviewがあり、かつquestionがあるbookが返される
- 例2：reviewがあり、かつauthorがいるbookが返される

#### 4. 

[例]
```
$ Author.joins(books: :reviews)
```
- reviewのあるbookを持つauthorを返す。

#### 6. 取得するテーブルに結合先のカラムを追加する
```
$ Book.joins(:reviews).select('reviews.*, reviews.content')
```
- 内部結合だけでは、カラムは追加されないため、直接結合先のカラムを取得できない
- 上の例では、`Book.joins(:reviews).select('reviews.*, reviews.content').first.content`のように直接カラムを取得できる

#### 7. 結合先のテーブルに対して条件を指定する
```
# 例1（単数結合）
Book.joins(:reviews).where(reviews: { id: 1})
# 例2（複数結合）
Author.joins(books: :reviews).where(reviews: { id: 5})
```
- 例1：idが1のレビューコメントを持つBookデータを取得
- 例2：idが5のレビューを持つbookのauthorを返す
