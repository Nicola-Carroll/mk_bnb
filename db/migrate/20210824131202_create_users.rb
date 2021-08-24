class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name, null: false, :limit => 20
      t.string :last_name, null: false, :limit => 20
      t.string :user_name, null: false, :limit => 20
      t.string :email, null: false, :limit => 60
      # t.string :phone_number, null: false, :limit => 11
      t.string :password, null: false, :limit => 20
    end
  end
end
