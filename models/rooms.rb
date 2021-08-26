require 'active_record'
require_relative '../helper_methods'

class Room < ActiveRecord::Base
  serialize :availability, Array

  def self.update_availability(id, params)
    room = self.find_by(id: id)
    room.availability -= unavailable_dates(params)
    room.save
  end

end

