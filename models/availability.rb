require 'date'

# this class is dependent on string date format being yyyy-mm-dd

class Availability

  def initialize(date_1, date_2)
    @date_1 = date_1
    @date_2 = date_2
    set_min_and_max
  end

  def return_array
    (@min_date..@max_date).to_a
  end

  def range_as_strings
    return_array.map { |date| date.strftime("%Y-%m-%d") }
  end

  private

  def string_to_date(string)
    date_array = string.split("-").map(&:to_i)
    Date.new(date_array[0], date_array[1], date_array[2])
  end

  def set_min_and_max
    @min_date = string_to_date([@date_1,@date_2].min)
    @max_date = string_to_date([@date_1,@date_2].max)
  end

end

a = ["2021-08-25", "2021-08-26", "2021-08-27", "2021-08-28"]
b = ["2021-08-25", "2021-08-26", "2021-08-27", "2021-08-28", "2021-08-29", "2021-08-30", "2021-09-01"]
(b & a).any?