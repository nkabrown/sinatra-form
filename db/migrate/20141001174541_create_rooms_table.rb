class CreateRoomsTable < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :location
      t.integer :room_number
    end
  end
end
