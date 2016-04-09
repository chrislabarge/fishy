json.array!(@lights) do |light|
  json.extract! light, :id
  json.url light_url(light, format: :json)
end
