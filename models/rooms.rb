require 'active_record'

class Room < ActiveRecord::Base
  serialize :availability, Array

end