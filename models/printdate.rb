require 'date'

class PrintDate
  def self.selected_date(date_string)
    date = Date.strptime(date_string,"%Y-%m-%d")
    date.strftime("%d %B %Y")
  end
end
