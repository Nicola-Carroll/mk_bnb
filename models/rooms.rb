require 'active_record'
require_relative '../helper_methods'

class Room < ActiveRecord::Base
  serialize :availability, Array
  has_many :requests

  module ClassMethods
    private

    def availability_as_dates(id)
      self.find_by(id: id).availability.map { |string| string_to_date(string) }
    end

    def availability_as_date_ranges(id)
      date_array = availability_as_dates(id).sort.to_set.to_a
      previous = date_array[0]

      date_array.slice_before do |date|
        previous, previous2 = date, previous
        previous2 + 1 != date
      end.map do |range_start_date, *, range_end_date| 
        range_end_date ? Range.new(range_start_date,range_end_date) : Range.new(range_start_date,range_start_date)
      end

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

  def self.max_date_from_min(id, check_in_as_string)
    check_in = string_to_date(check_in_as_string)
    max_check_out = availability_as_date_ranges(id).select { |range| range.include? check_in }.max.max
    max_check_out.strftime("%Y-%m-%d")
  end


end

