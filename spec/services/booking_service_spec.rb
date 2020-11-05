# frozen_string_literal: true

RSpec.describe BookingService do
  describe '.process_file' do
    it 'instantiates a new cinema and calls its process_bookings method with the given file' do
      cinema = double(:cinema)
      allow(Cinema).to receive(:new).and_return(cinema)
      expect(cinema).to receive(:process_bookings).with('sample_booking_requests')

      expect(BookingService.process_file('sample_booking_requests')).to eq cinema
    end
  end
end
