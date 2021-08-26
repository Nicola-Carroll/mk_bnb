require 'active_record'
require_relative '../helper_methods'

class Room < ActiveRecord::Base
  serialize :availability, Array

  module ClassMethods
    private

    def availability_as_dates(id)
      self.find_by(id: id).availability.map { |string| string_to_date(string) }
    end

  end

  extend ClassMethods

  def self.update_availability(id, array_of_unavailable_dates)
    room = self.find_by(id: id)
    room.availability -= array_of_unavailable_dates
    room.save
  end

  def self.max_available_date(id)
    max = availability_as_dates(id).max
    [Date.today,max].max.strftime("%Y-%m-%d")
  end

  def self.min_available_date(id)
    min = availability_as_dates(id).min
    [Date.today,min].max.strftime("%Y-%m-%d")
  end


end

