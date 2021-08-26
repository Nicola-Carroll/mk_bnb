class AddDateFromAndDateToToRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :date_from, :date
    add_column :requests, :date_to, :date
  end
end
