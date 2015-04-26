class AddAssetCategoryToAssets < ActiveRecord::Migration
  def change
    add_reference :assets, :asset_category, index: true, foreign_key: true
  end
end
