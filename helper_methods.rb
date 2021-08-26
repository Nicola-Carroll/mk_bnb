require 'yaml'

def string_to_array(str)
  str.gsub!(/(\,)(\S)/, "\\1 \\2")
  YAML::load(str)
end

def unavailable_dates(params)
  params.map { |date , status | date if status=="unavailable" }
end

def selected_date(date)
  string = date.split('-').map(&:to_i)
  new_date = Date.new(string[0], string[1], string[2])
  new_date.strftime("%d. %B %Y")
end