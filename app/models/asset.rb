class Asset < ActiveRecord::Base
  belongs_to :room
  belongs_to :asset_category
end
