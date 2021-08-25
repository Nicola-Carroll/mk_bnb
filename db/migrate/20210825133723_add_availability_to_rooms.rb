class AddAvailabilityToRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :availability, :string
  end
end
