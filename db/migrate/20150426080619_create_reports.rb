class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.datetime :created_at
      t.text :description
    end
    add_index :reports, :created_at
  end
end
