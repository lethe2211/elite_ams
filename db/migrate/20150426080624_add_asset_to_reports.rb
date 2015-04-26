class AddAssetToReports < ActiveRecord::Migration
  def change
    add_reference :reports, :asset, index: true, foreign_key: true
  end
end
