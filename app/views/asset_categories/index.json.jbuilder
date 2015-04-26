json.array!(@asset_categories) do |asset_category|
  json.extract! asset_category, :id, :name
  json.url asset_category_url(asset_category, format: :json)
end
