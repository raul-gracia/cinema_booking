RSpec.describe Seat do
  describe ".new" do
    it "initializes a new object with the given params" do
      seat = Seat.new(number: 1, row: 1, column: 1, booked: true)

      expect(seat.number).to eq 1
      expect(seat.row).to eq 1
      expect(seat.column).to eq 1
      expect(seat.booked).to eq true
    end
  end

  describe "#free?" do
    it "returns true if the booked property is false" do
      free_seat = Seat.new(number: 1, row: 1, column: 1, booked: false)
      expect(free_seat).to be_free

      full_seat = Seat.new(number: 1, row: 1, column: 1, booked: true)
      expect(full_seat).to_not be_free
    end
  end
end
