require 'active_record'

class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true

  def self.can_log_in(user_name, password)
      signed_in_user = User.find_by(user_name: "#{user_name}", password: "#{password}")
      return signed_in_user
  end

end