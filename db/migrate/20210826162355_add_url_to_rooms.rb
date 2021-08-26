class AddUrlToRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :picture_url, :string
  end
end
