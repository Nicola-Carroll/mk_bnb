require 'active_record'

class Room < ActiveRecord::Base
  serialize :availability, Array


  def remove_dates(availability, params)
    availability - unavailable_dates(params)
  end

  def unavailable_dates(params)
    params.map { |date , status | date if status=="unavailable" }
  end

  def self.update_availability(id, params)
    room = self.find_by(id: id)
    room.availability = remove_dates(room.availability, params)
  end

#  we have an array of dates that we want to edit
#  and we have key, value pairs of params params[date] = status
#  we want to update our array based on the value of status
# from the paramaters we want to get a list of dates which we are removing from the availaibily array

end