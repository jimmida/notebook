json.array!(@lessons) do |lesson|
  json.extract! lesson, :id, :course_id, :name, :url
  json.url lesson_url(lesson, format: :json)
end
