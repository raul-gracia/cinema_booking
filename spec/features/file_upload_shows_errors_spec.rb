# frozen_string_literal: true

RSpec.feature 'File upload shows errors', type: :feature do
  it 'shows an input to upload a file' do
    visit '/'
    expect(page).to have_css '#bookings_file'
  end
  it 'displays the errors on the UI' do
    visit '/'

    attach_file('bookings_file', 'sample_booking_requests')
    click_button('Upload Bookings File')

    expect(page).to have_content 'Booking Errors'
    expect(page).to have_css '#errors'

    errors = all('#errors p')
    expect(errors.count).to eq 11
    expect(errors.first.text).to eq 'Booking ID: 63 rejected because is out of bounds'
  end
end
