class CreateAssetCategories < ActiveRecord::Migration
  def change
    create_table :asset_categories do |t|
      t.string :name, limit: 32
    end
    add_index :asset_categories, :name, unique: true
  end
end
