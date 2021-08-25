require './models/availability'

describe Availability do

  let(:min_date) { Date.today.strftime("%Y-%m-%d") }
  let(:max_date) { (Date.today + 32).strftime("%Y-%m-%d") }
  let(:availability) { 
    described_class.new(min_date, max_date) 
  }

  context '#return_array' do

    it 'returns an array with the current number of dates' do
      #availability.return_range - we want this to be an array of 32 unique elements
      expect(availability.return_array.to_set.count).to eq 33
    end

    it 'returns the correct max and min dates' do
      availability.return_array.each do |date|
        expect(date).to be_between(Date.today, (Date.today + 32))
      end
    end

  end

end