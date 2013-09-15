json.array!(@category_reps) do |category_rep|
  json.extract! category_rep, :category
  json.url category_rep_url(category_rep, format: :json)
end