Rails.application.routes.draw do
  root to: "cinema#bookings"
  post "/", to: "cinema#process_bookings"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
