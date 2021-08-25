require 'yaml'

def string_to_array(str)
  str.gsub!(/(\,)(\S)/, "\\1 \\2")
  YAML::load(str)
end