require 'date'

class DateFilter

  def initialize(checkin_date, checkout_date)
    @checkin_date = checkin_date
    @checkout_date= checkout_date
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
    @min_date = string_to_date([@checkin_date,@checkout_date].min)
    @max_date = string_to_date([@checkin_date,@checkout_date].max)
  end
end

# x = DateFilter.new('2021-08-25', '2021-09-10')
# p x.range_as_strings

# a = ["2021-08-25", "2021-08-26", "2021-08-27", "2021-08-28"]
# b = ["2021-08-25", "2021-08-26", "2021-08-27", "2021-08-28", "2021-08-29", "2021-08-30", "2021-08-31", "2021-09-01", "2021-09-02", "2021-09-03", "2021-09-04", "2021-09-05", "2021-09-06", "2021-09-07", "2021-09-08", "2021-09-09", "2021-09-10"]
# p (b & a).any?