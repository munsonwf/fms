json.array!(@case_files) do |case_file|
  json.extract! case_file, :id, :client_id, :name, :matter, :file_no, :date_opened, :date_closed, :location
  json.url case_file_url(case_file, format: :json)
end
