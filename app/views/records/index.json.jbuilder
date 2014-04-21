json.array!(@records) do |record|
  json.extract! record, :id, :desc, :sum, :date, :kind
  json.url record_url(record, format: :json)
end
