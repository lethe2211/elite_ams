json.array!(@assets) do |asset|
  json.extract! asset, :id, :description, :room_id, :asset_category_id
  json.url asset_url(asset, format: :json)
end
