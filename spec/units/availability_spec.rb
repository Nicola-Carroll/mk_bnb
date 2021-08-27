require './models/availability'

describe Availability do

  let(:today) { Date.today }
  let(:min_date) { today.strftime("%Y-%m-%d") }
  let(:max_date) { (today + 32).strftime("%Y-%m-%d") }
  let(:availability) { 
    described_class.new(min_date, max_date) 
  }

  context '#return_array' do

    it 'returns an array with the current number of dates' do
      expect(availability.return_array.to_set.count).to eq 33
    end

    it 'returns the correct max and min dates' do
      availability.return_array.each do |date|
        expect(date).to be_between(today, (today + 32))
      end
    end

  end

  context "#range_as_strings" do
    
    it 'returns array of dates as array of strings' do
      availability.range_as_strings[0] = today.strftime("%Y-%m-%d")
    end
  end

end