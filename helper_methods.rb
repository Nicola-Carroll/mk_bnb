require 'yaml'

def string_to_array(str)
  str.gsub!(/(\,)(\S)/, "\\1 \\2")
  YAML::load(str)
end


def unavailable_dates(params)
  params.map { |date , status | date if status=="unavailable" }
end

<%= @filtered_dates %>
<% Room.all.each do |room| %>
  <h2><%= (room.availability & @filtered_dates ).any? %></h2>
<% end %>