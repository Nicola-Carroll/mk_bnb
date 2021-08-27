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
    castle = Room.create!(
      title: 'Spooky Castle', 
      description: 'very scary and cold',
      price_per_night: 10, 
      user_id: will.id, 
      availability: [
        "2021-01-01",
        "2021-01-02",
        "2021-01-03",
        "2021-01-04",
        "2021-01-05",
      ]
    )
  end

  let(:will_id) { User.last.id }
  let(:castle_id) { Room.last.id }

  context 'is_valid' do

    it 'returns true for a valid request' do
      BookingRequest.create!(
        user_id: will_id,
        room_id: castle_id,
        booking_status: "pending",
        date_from: "2021-01-01",
        date_to: "2021-01-03"
      )
      expect(BookingRequest.is_valid(BookingRequest.last.id)).to eq true
    end
    
    it 'returns false for an invalid request - unavailable dates' do
      request_2 = BookingRequest.create!(
        user_id: will_id,
        room_id: castle_id,
        booking_status: "pending",
        date_from: "2021-01-01",
        date_to: "2021-02-03"
      )
      expect(BookingRequest.is_valid(request_2.id)).to eq false
    end

    it 'returns false for an invalid request - no night' do
      request_3 = BookingRequest.create!(
        user_id: will_id,
        room_id: castle_id,
        booking_status: "pending",
        date_from: "2021-01-01",
        date_to: "2021-01-01"
      )
      expect(BookingRequest.is_valid(request_3.id)).to eq false
    end


  end

  context "auto_decline" do

    it 'updates a bookings status' do
      BookingRequest.create!(
        user_id: will_id,
        room_id: castle_id,
        booking_status: "pending",
        date_from: "2021-01-01",
        date_to: "2021-01-01"
      )
      p BookingRequest.last.id
      BookingRequest.auto_decline(BookingRequest.last.id)
      expect(BookingRequest.last.booking_status).to eq "auto-declined"
    end
  
  end

  context "process_request_response" do

    it 'updates booking status' do
      BookingRequest.create!(
        user_id: will_id,
        room_id: castle_id,
        booking_status: "pending",
        date_from: "2021-01-01",
        date_to: "2021-01-03"
      )
      params = { "#{BookingRequest.last.id}" => "Approve" }
      BookingRequest.process_request_reponse(params)
      expect(BookingRequest.last.booking_status).to eq "approved"
    end

    it 'updates availability' do
      BookingRequest.create!(
        user_id: will_id,
        room_id: castle_id,
        booking_status: "pending",
        date_from: "2021-01-01",
        date_to: "2021-01-03"
      )
      params = { "#{BookingRequest.last.id}" => "Approve" }
      expect(BookingRequest).to receive(:update_availability).with(params)
      BookingRequest.process_request_reponse(params)
    end
    
  end

end