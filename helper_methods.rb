require 'yaml'

def string_to_array(str)
  str.gsub!(/(\,)(\S)/, "\\1 \\2")
  YAML::load(str)
end


def unavailable_dates(params)
  params.map { |date , status | date if status=="unavailable" }
end