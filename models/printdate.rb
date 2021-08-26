require 'date'

class PrintDate
  def self.selected_date(date)
    string = date.split('-').map(&:to_i)
    new_date = Date.new(string[0], string[1], string[2])
    new_date.strftime("%d %B %Y")
  end
end
