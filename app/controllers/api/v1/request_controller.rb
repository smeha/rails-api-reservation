class Api::V1::RequestController < ApplicationController
	before_action :authentication

	# curl -X POST -H "Content-Type: application/json" -H "Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJTaW1wbGUgQVBJIiwiYWxnb3JpdGhtIjoiSFMyNTYifQ.aL9fcGXxlSGsEJ4_o9ed7gqBhbnYPbcPlO92RIaSjOc" -d '{"customer":{ "first_name":"First", "last_name":"Last"},"vehicle":{"make":"Volvo","model":"245DL","vin":"SDHJSKHD324234"},"time_slot":{"time":"12:00"} }' http://0.0.0.0:3000/api/v1/request
	def create
		passed_params = params.permit(permitted_create_params)
		@customer = Customer.new(passed_params[:customer])
		if @customer.save
			@vehicle = @customer.vehicles.new(passed_params[:vehicle])
			passed_params[:time_slot][:active] = true
			@vehicle.time_slot = TimeSlot.new(passed_params[:time_slot])
			unless @vehicle.save		
				@customer.destroy			
			end
		end
		puts "-------------------------------------------------"
		puts @customer.inspect
		puts @vehicle.inspect
		puts @vehicle.time_slot.inspect
		puts "-------------------------------------------------"
		render :json => "Time slot reserved".to_json, :status => :ok
	end


	def permitted_create_params
		{
			customer: [
				:first_name, :last_name
			],
			vehicle: [
				:make,:model,:vin
			],
			time_slot: [
				:time
			]
		}
	end

end