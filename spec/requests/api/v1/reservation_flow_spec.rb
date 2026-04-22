require "rails_helper"

RSpec.describe "API V1 reservation flow", type: :request do
  let(:jwt_secret) { "9C29AA3B6A47A440B20067DFF29F556EF22AD88A5D8F5E01F6B1A6962397C45A" }

  before do
    TimeSlot.delete_all
    Vehicle.delete_all
    Customer.delete_all
  end

  describe "GET /api/v1/customer" do
    it "lists customers with a valid token" do
      create_customer
      get "/api/v1/customer", headers: auth_headers

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body).to include(a_hash_including(customer_payload))
    end
  end

  describe "POST /api/v1/request" do
    it "creates a reservation with a valid token" do
      expect { create_reservation }.to change_reservation_counts

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body).to eq("Time slot reserved")
      expect(TimeSlot.order(:created_at).last).to be_active
    end
  end

  def auth_headers
    {
      "Authorization" => JWT.encode({ iss: "Simple API" }, jwt_secret, "HS256")
    }
  end

  def create_customer
    Customer.create!(customer_payload.symbolize_keys)
  end

  def customer_payload
    {
      "first_name" => "Jane",
      "last_name" => "Driver"
    }
  end

  def create_reservation
    post "/api/v1/request",
      params: reservation_params,
      headers: auth_headers,
      as: :json
  end

  def change_reservation_counts
    change(Customer, :count).by(1)
      .and change(Vehicle, :count).by(1)
      .and change(TimeSlot, :count).by(1)
  end

  def reservation_params
    {
      customer: {
        first_name: "Jane",
        last_name: "Driver"
      },
      vehicle: {
        make: "Volvo",
        model: "245DL",
        vin: "TESTVIN#{SecureRandom.hex(6).upcase}"
      },
      time_slot: {
        time: "12:00"
      }
    }
  end
end
