class AddAssetCategoryToReports < ActiveRecord::Migration
  def change
    add_reference :reports, :asset_category, index: true, foreign_key: true
  end
end
