class Api::V1::VehicleController < ApplicationController
	before_action :authentication

	# curl -X GET -H "Content-Type: application/json" -H "Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJTaW1wbGUgQVBJIiwiYWxnb3JpdGhtIjoiSFMyNTYifQ.aL9fcGXxlSGsEJ4_o9ed7gqBhbnYPbcPlO92RIaSjOc" http://0.0.0.0:3000/api/v1/vehicle
	def index
		vehicles = Vehicle.all.select(:make,:model,:vin) 
		if vehicles
			render :json => vehicles.to_json, :status => :ok
		end
	end

end