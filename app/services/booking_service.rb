class BookingService
  def self.process_file(file)
    cinema = Cinema.new(rows: 100, columns: 50)
    cinema.process_bookings(file)

    cinema
  end
end
