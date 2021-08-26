require 'active_record'
require './models/availability'
require './models/rooms'

class BookingRequest < ActiveRecord::Base
  self.table_name = "requests"
  # validate :booking_must_be_at_least_one_night

  REQUEST_RESPONSES = ["Approve", "Decline"]
  REQUEST_STATUSES = {
    "Approve" => "approved",
    "Decline" => "declined"
  }

  # def booking_must_be_at_least_one_night
  #   (charge_to - charge_from).to_i >= 1
  # end

  module ClassMethods
    private
    
    def update_status(id, response)
      request = self.find_by(id: id)
      request.booking_status = REQUEST_STATUSES[response]
      request.save
    end
    
    def request_ids_from(params)
      params.map { |request_id, response| request_id if REQUEST_RESPONSES.include?(response) }
    end

    def dates_array_from(id, params)
      request = self.find_by(id: id)
      dates = Availability.new(
        request.date_from.to_s,
        request.date_to.to_s
      ).range_as_strings
      dates.pop
      dates
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
        if params[id] == "Approve"
          Room.update_availability(
            room_id_from_request(id),
            dates_array_from(id, params)
          )
        end
      end
    end
  
  end

  extend ClassMethods

  def self.process_request_reponse(params)
    update_availability(params)
    update_statuses(params)
  end

  # def self.auto_reject


end
