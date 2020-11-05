class Cinema
  attr_reader :errors, :seats

  def initialize(rows:, columns:)
    @seats = initialize_seats(rows, columns)
    @errors = []
  end

  def process_bookings(file)
    File.read(file).each_line do |line|
      match_data = line.match(/\((?<id>\d+),(?<first_row>\d+):(?<first_column>\d+),(?<last_row>\d+):(?<last_column>\d+)\),?/)
      @errors << "Malformed line: #{line}" and next if match_data.nil?

      booking = Booking.new(match_data.named_captures)
      if booking.valid?
        apply_booking(booking)
      else
        @errors << booking.error
      end
    end
  end

  private

  def initialize_seats(rows_number, columns_number)
    layout = Array.new(rows_number) { Array.new(columns_number) }
    seat_number = 0

    rows_number.times do |i|
      columns_number.times do |j|
        seat_number += 1
        layout[i][j] = Seat.new(number: seat_number, row: i, column: j, booked: false)
      end
    end
    layout
  end

  def apply_booking(booking)
    @errors << "Booking ID: #{booking.id} rejected because is out of bounds" and return if out_of_bounds?(booking)
    @errors << "Booking ID: #{booking.id} rejected because leaves a gap of one seat" and return if leaves_a_gap?(booking)
    @errors << "Booking ID: #{booking.id} rejected because intended seats are not available" and return unless available_seats?(booking)

    booking.seats.each do |seat|
      seats[seat[:row]][seat[:column]].booked = true
    end
  end

  def leaves_a_gap?(booking)
    gap_before?(booking) || gap_after?(booking)
  end

  def gap_before?(booking)
    seat_before = previous_seat(booking.first_row, booking.first_column)
    two_seats_before = previous_seat(seat_before.row, seat_before.column)

    seat_before.booked == false && two_seats_before.booked == true
  end

  def gap_after?(booking)
    seat_after = next_seat(booking.last_row, booking.last_column)
    two_seats_after = next_seat(seat_after.row, seat_after.column)

    seat_after.booked == false && two_seats_after.booked == true
  end

  def previous_seat(row, column)
    prev_column = column - 1
    prev_row = row

    if prev_column < 0
      prev_column = 0
      prev_row = row - 1
    end

    seats[prev_row][prev_column]
  end

  def next_seat(row, column)
    next_column = column + 1
    next_row = row

    if next_column >= @seats.first.size
      next_column = 0
      next_row = row + 1
    end

    seats[next_row][next_column]
  end

  def available_seats?(booking)
    booking.seats.all? { |seat| seats[seat[:row]][seat[:column]].free? }
  rescue => ex
    binding.pry
  end

  def out_of_bounds?(booking)
    booking.seats.any? { |seat| seats[seat[:row]][seat[:column]].nil? }
  end
end
