require 'active_record'
require './models/availability'
require './models/rooms'

class BookingRequest < ActiveRecord::Base
  self.table_name = "requests"

  REQUEST_RESPONSES = ["Approve", "Decline"]
  REQUEST_STATUSES = {
    "Approve" => "approved",
    "Decline" => "declined"
  }

  module ClassMethods
    private
    
    def update_status(id, response)
      request = self.find_by(id: id.to_i)
      request.booking_status = REQUEST_STATUSES[response]
      request.save
    end
    
    def request_ids_from(params)
      params.map { |key, value| key if REQUEST_RESPONSES.include?(value) }
    end

    def dates_array_from(params)
      request_ids = request_ids_from(params)
      request_ids.map do |id|
        request = self.find_by(id: id)
        dates = Availability.new(
          request.date_from.to_s,
          request.date_to.to_s
        ).range_as_strings
        dates.pop
        dates
      end
    end

    def update_statuses(params)
      request_ids = request_ids_from(params)
      request_ids.each do |id|
        update_status(id, params[id])
      end
    end

    def room_id_from_request(id)
      self.find_by(id: id).room_id
    end
  

    def update_availability(params)
      request_ids = request_ids_from(params)
      request_ids.each do |id|
        Room.update_availability(
          room_id_from_request(id),
          dates_array_from(params)
        )
      end
    end
  
  end

  extend ClassMethods

  def self.process_request_reponse(params)
    update_availability(params)
    update_statuses(params)
  end


end