json.array!(@time_entries) do |time_entry|
  json.extract! time_entry, :id, :user_id, :spent_time, :note
  json.url time_entry_url(time_entry, format: :json)
end
