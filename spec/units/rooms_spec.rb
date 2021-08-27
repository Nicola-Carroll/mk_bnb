require './models/request'

describe BookingRequest do
  
  before do
    will = User.create!(
      first_name: 'Willy', 
      last_name: 'Balm', 
      user_name: 'Hilliblilly', 
      email: 'hilly@example.com', 
      password: 'griltheAnim4lz'
    )

  end

  let(:will_id) { User.last.id }
  # let(:castle_id) { Room.last.id }

  context 'update_availability' do


  end

  context "max_available_date" do
    
    it 'returns the max date in availability' do
      Room.create!(
        title: 'Spooky Castle', 
        description: 'very scary and cold',
        price_per_night: 10, 
        user_id: will_id, 
        availability: [
          "2021-01-01",
          "2021-01-02",
          "2021-01-03",
          "2021-01-04",
          "2021-01-05",
        ]
      )
      castle_id = Room.last.id
      expect(Room.max_available_date(castle_id)).to eq Date.today.strftime("%Y-%m-%d")
    end
  
  end

  context 'min_available_date' do


  end

  context "max_date_from_min" do

  
  end


end