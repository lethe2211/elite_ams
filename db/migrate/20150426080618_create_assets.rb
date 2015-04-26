class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :description, limit: 32
    end
  end
end
