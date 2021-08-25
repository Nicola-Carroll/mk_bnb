class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      #date
      t.string :booking_status, null: false, :limit => 20
    end
  end
end