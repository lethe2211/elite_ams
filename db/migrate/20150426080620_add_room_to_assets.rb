class AddRoomToAssets < ActiveRecord::Migration
  def change
    add_reference :assets, :room, index: true, foreign_key: true
  end
end
