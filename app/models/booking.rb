class Booking
  attr_reader :error, :id, :first_row, :first_column, :last_row, :last_column

  def initialize(data)
    @id = data["id"].to_i
    @first_row = data["first_row"].to_i
    @first_column = data["first_column"].to_i
    @last_row = data["last_row"].to_i
    @last_column = data["last_column"].to_i
  end

  def valid?
    seats_on_same_row? && five_or_less_seats?
  end

  def seats
    seats = []
    (@first_row..@last_row).each do |row|
      (@first_column..@last_column).each do |column|
        seats << { row: row, column: column }
      end
    end
    seats
  end

  private

  def seats_on_same_row?
    if @first_row == @last_row
      true
    else
      @error = "Booking ID: #{id} rejected because all seats must be on the same row"
      false
    end
  end

  def five_or_less_seats?
    if (@first_column..@last_column).count <= 5
      true
    else
      @error = "Booking ID: #{id} rejected because you can only book 5 or less seats"
      false
    end
  end
end
