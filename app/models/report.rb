class Report < ActiveRecord::Base
  belongs_to :room
  belongs_to :asset_category
  belongs_to :asset
end
