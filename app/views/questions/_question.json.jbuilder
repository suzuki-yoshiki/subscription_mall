json.extract! question, :id, :detail, :answer, :created_at, :updated_at
json.url question_url(question, format: :json)
