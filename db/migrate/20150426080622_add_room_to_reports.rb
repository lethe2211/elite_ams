class AddRoomToReports < ActiveRecord::Migration
  def change
    add_reference :reports, :room, index: true, foreign_key: true
  end
end
