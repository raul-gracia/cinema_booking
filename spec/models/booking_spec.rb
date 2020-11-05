# frozen_string_literal: true

RSpec.describe Booking do
  let(:valid_booking) do
    {
      'id' => 1,
      'first_row' => 1,
      'first_column' => 1,
      'last_row' => 1,
      'last_column' => 4
    }
  end
  describe '.initialize' do
    it 'initializes a new instance with the given params' do
      booking = Booking.new(valid_booking)

      expect(booking.id).to eq 1
      expect(booking.first_row).to eq 1
      expect(booking.first_column).to eq 1
      expect(booking.last_row).to eq 1
      expect(booking.last_column).to eq 4
      expect(booking.error).to eq nil
    end
  end
  describe '#valid?' do
    context 'with all valid conditions' do
      it 'returns true' do
        booking = Booking.new(valid_booking)
        expect(booking).to be_valid
      end
    end
    context 'with seats on different rows' do
      let(:invalid_booking) do
        {
          'id' => 1,
          'first_row' => 1,
          'first_column' => 1,
          'last_row' => 3,
          'last_column' => 1
        }
      end
      it 'returns false' do
        booking = Booking.new(invalid_booking)
        expect(booking).to_not be_valid
      end
    end
    context 'with more than 5 seats' do
      let(:invalid_booking) do
        {
          'id' => 1,
          'first_row' => 1,
          'first_column' => 1,
          'last_row' => 1,
          'last_column' => 8
        }
      end
      it 'returns false' do
        booking = Booking.new(invalid_booking)
        expect(booking).to_not be_valid
      end
    end
  end
  context '#seats' do
    it 'returns an array of hashes with the row and column of each seat of the booking' do
      booking = Booking.new(valid_booking)
      seats = [
        { row: 1, column: 1 },
        { row: 1, column: 2 },
        { row: 1, column: 3 },
        { row: 1, column: 4 }
      ]
      expect(booking.seats).to eq seats
    end
  end
end
