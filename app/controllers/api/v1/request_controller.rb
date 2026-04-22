class Api::V1::RequestController < ApplicationController
  before_action :authentication

  # curl -X POST -H "Content-Type: application/json" -H "Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJTaW1wbGUgQVBJIiwiYWxnb3JpdGhtIjoiSFMyNTYifQ.aL9fcGXxlSGsEJ4_o9ed7gqBhbnYPbcPlO92RIaSjOc" -d '{"customer":{ "first_name":"First", "last_name":"Last"},"vehicle":{"make":"Volvo","model":"245DL","vin":"SDHJSKHD324234"},"time_slot":{"time":"12:00"} }' http://0.0.0.0:3000/api/v1/request
  def create
    reservation = create_reservation!

    render json: "Time slot reserved".to_json, status: :ok
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_content
  end


  def permitted_create_params
    {
      customer: [
        :first_name, :last_name
      ],
      vehicle: [
        :make, :model, :vin
      ],
      time_slot: [
        :time
      ]
    }
  end

  private
    def create_reservation!
      passed_params = params.permit(permitted_create_params)

      Customer.transaction do
        customer = Customer.create!(passed_params[:customer])
        vehicle = customer.vehicles.create!(passed_params[:vehicle])
        vehicle.create_time_slot!(passed_params[:time_slot].merge(active: true))
      end
    end
end
