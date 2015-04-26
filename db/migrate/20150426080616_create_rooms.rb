class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name, limit: 32
    end
    add_index :rooms, :name, unique: true
  end
end
