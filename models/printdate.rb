require_relative '../helper_methods'

class PrintDate
  def self.selected_date(date)
    date_string = date.strftime("%Y-%m-%d")
    Date.strptime(date_string,"%Y-%m-%d").strftime("%d %B %Y")
  end

  def self.selected_string(date)
    Date.strptime(date,"%Y-%m-%d").strftime("%d %B %Y")
  end
end
