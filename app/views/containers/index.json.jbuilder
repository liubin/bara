json.array!(@containers) do |container|
  json.extract! container, :id, :name, :cid, :user_id, :json
  json.url container_url(container, format: :json)
end
