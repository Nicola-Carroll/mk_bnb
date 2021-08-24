class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :title, null: false, :limit => 100
      t.string :description, null: false
      t.float :price_per_night, null: false
      t.references :user, null: false, foreign_key: true
    end
  end
end