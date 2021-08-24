require './models/user.rb'

describe User do
  context '.can_log_in' do
    it 'registered user is able to log in' do
      User.delete_all
      User.create!(
        first_name: 'Willy', 
        last_name: 'Balm', 
        user_name: 'Hilliblilly', 
        email: 'hilly@example.com', 
        password: 'griltheAnim4lz'
      )
      expect(User.can_log_in("Hilliblilly", "griltheAnim4lz")).to eq(User.all.last)
    end

    it 'checks that an unregistered user is unable to log in' do
      expect(User.can_log_in("Willy", "Wally")).to be_nil
    end
  end
end