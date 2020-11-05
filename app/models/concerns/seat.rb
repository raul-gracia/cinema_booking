class Seat
  attr_accessor :number, :row, :column, :booked

  def initialize(number:, row:, column:, booked: false)
    @number = number
    @row = row
    @column = column
    @booked = booked
  end

  def free?
    !booked
  end
end
