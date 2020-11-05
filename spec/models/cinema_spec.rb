# frozen_string_literal: true

RSpec.describe Cinema do
  describe '.initialize' do
    it 'initializes a new cinema instance with a matrix seats' do
      cinema = Cinema.new(rows: 10, columns: 15)

      expect(cinema.seats.size).to eq 10
      expect(cinema.seats.first.size).to eq 15
      expect(cinema.seats.first.first).to be_a Seat
      expect(cinema.errors).to eq []
    end
  end
  describe '#process_bookings' do
    context 'with a malformed input' do
      it 'includes malformed errors' do
        cinema = Cinema.new(rows: 10, columns: 15)
        cinema.process_bookings('spec/test_files/malformed')

        error = 'Malformed line: (3,10:3-10:5),,'

        expect(cinema.errors).to eq [error]
      end
    end
    context 'with an invalid booking' do
      context '(seats on same row)' do
        let(:input_file) { 'spec/test_files/invalid_booking_not_same_row' }
        it 'includes invalid booking errors' do
          cinema = Cinema.new(rows: 10, columns: 15)
          cinema.process_bookings(input_file)

          error = 'Booking ID: 1 rejected because all seats must be on the same row'

          expect(cinema.errors).to eq [error]
        end
      end
      context '(more than 5 seats)' do
        let(:input_file) { 'spec/test_files/invalid_booking_more_than_5' }
        it 'includes invalid booking errors' do
          cinema = Cinema.new(rows: 10, columns: 15)
          cinema.process_bookings(input_file)

          error = 'Booking ID: 1 rejected because you can only book 5 or less seats'

          expect(cinema.errors).to eq [error]
        end
      end
    end

    context 'with valid booking' do
      context '(out of bounds)' do
        let(:input_file) { 'spec/test_files/valid_booking_out_of_bounds' }
        it 'includes invalid booking errors' do
          cinema = Cinema.new(rows: 10, columns: 15)
          cinema.process_bookings(input_file)

          error = 'Booking ID: 1 rejected because is out of bounds'

          expect(cinema.errors).to eq [error]
        end
      end
      context '(leaves gaps)' do
        let(:input_file) { 'spec/test_files/valid_booking_with_gaps' }
        it 'includes invalid booking errors' do
          cinema = Cinema.new(rows: 10, columns: 15)
          cinema.process_bookings(input_file)

          error = 'Booking ID: 2 rejected because leaves a gap of one seat'

          expect(cinema.errors).to eq [error]
        end
      end
      context '(seats already booked)' do
        let(:input_file) { 'spec/test_files/valid_booking_seats_taken' }
        it 'includes invalid booking errors' do
          cinema = Cinema.new(rows: 10, columns: 15)
          cinema.process_bookings(input_file)

          error = 'Booking ID: 2 rejected because intended seats are not available'

          expect(cinema.errors).to eq [error]
        end
      end
    end
  end
end
