class AddDateToRequests < ActiveRecord::Migration[5.2]
  def change
    change_column :requests, :date_from, :date
    change_column :requests, :date_to, :date
  end
end
