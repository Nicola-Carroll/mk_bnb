require 'active_record'
require_relative '../helper_methods'

class Room < ActiveRecord::Base
  serialize :availability, Array

  def self.update_availability(id, array_of_unavailable_dates)
    room = self.find_by(id: id)
    room.availability -= unavailable_dates(array_of_unavailable_dates)
    room.save
  end

end

