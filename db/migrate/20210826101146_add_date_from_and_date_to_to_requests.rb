class AddDateFromAndDateToToRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :date_from, :string
    add_column :requests, :date_to, :string
  end
end
