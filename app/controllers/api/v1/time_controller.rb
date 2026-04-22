class Api::V1::TimeController < ApplicationController
  before_action :authentication

  # curl -X GET -H "Content-Type: application/json" -H "Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJTaW1wbGUgQVBJIiwiYWxnb3JpdGhtIjoiSFMyNTYifQ.aL9fcGXxlSGsEJ4_o9ed7gqBhbnYPbcPlO92RIaSjOc" http://0.0.0.0:3000/api/v1/time
  def index
    time_slots = TimeSlot.where(active: true).select(:time)
    formatted_time_slots = time_slots.map { |time_slot| { time: time_slot.time.strftime("%H:%M") } }

    render json: formatted_time_slots, status: :ok
  end
end
