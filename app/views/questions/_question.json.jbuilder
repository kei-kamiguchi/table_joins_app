json.extract! question, :id, :content, :user_id, :book_id, :created_at, :updated_at
json.url question_url(question, format: :json)
