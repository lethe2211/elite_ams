json.array!(@reports) do |report|
  json.extract! report, :id, :description, :room_id, :asset_category_id, :asset_id
  json.url report_url(report, format: :json)
end
