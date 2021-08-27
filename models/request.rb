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

    def request_date_range(id)
      request = self.find_by(id: id)
      dates = Availability.new(
        request.date_from.to_s,
        request.date_to.to_s
      ).range_as_strings
    end

    def dates_array_from(id, params)
      dates = request_date_range(id)
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

    def room_availability_from_request(id)
      room_id = self.find_by(id: id).room_id
      Room.find_by(id: room_id).availability
    end
  
    def update_availability(params)
      request_ids = request_ids_from(params)
      request_ids.each do |id|
        if params[id] == "Approve"
          decline_all_pending_requests_for_room(id)
          Room.update_availability(
            room_id_from_request(id),
            dates_array_from(id, params)
          )
        end
      end
    end

    def decline_all_pending_requests_for_room(id)
      accepted_request = self.find_by(id: id)
      pending_requests = self.where(room_id: accepted_request.room_id).where(booking_status: "pending").all
      requests_to_decline = pending_requests.select do |pending_request|
        !(request_date_range(id) & request_date_range(pending_request.id)).empty?
      end
      requests_to_decline.each { |request| self.auto_decline(request.id) }
    end
  
  end

  extend ClassMethods

  def self.process_request_reponse(params)
    update_availability(params)
    update_statuses(params)
  end

  def self.is_valid(id)
    request_dates = request_date_range(id)
    availability = room_availability_from_request(id)
    request_dates.all? { |date| availability.include? date } && request_dates.count > 1
  end

  def self.auto_decline(id)
    request = self.find_by(id: id)
    request.booking_status = "auto-declined"
    request.save
  end


end
