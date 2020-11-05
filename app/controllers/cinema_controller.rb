# frozen_string_literal: true

class CinemaController < ApplicationController
  def bookings; end

  def process_bookings
    @cinema = BookingService.process_file(params[:bookings_file]) if params[:bookings_file].present?

    render 'bookings'
  end
end
