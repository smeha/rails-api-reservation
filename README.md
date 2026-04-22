# Rails API Reservation
Simple reservation API, that allows through an API call capture customer's information, vehicle information, and secure a time slot.

## Tech Stack
* Ruby (v3.4.8)
* Rails (v8.1)
* PostgreSQL (v18)
* Bundler (4.0.10)
* RSpec-Rails (v8.0)
* RuboCop (via rubocop-rails-omakase + rubocop-performance + rubocop-rspec)
* JWT and CanCan for authorization handling and toking decoding

## How to run locally
### Prerequisites
- Ruby 3.4.8 (`rbenv install 3.4.8`)
- PostgreSQL running locally (`brew services start postgresql`)
- Bundler

### Install dependencies
```bash
bundle install
```

### Setup database
```bash
rails db:create
rails db:migrate
```

### Run the project
```bash
rails s
```

## Assumptions
* There can only be one customer with same First and Last name
* Unique vehicle by VIN
* Time
  * Verified only HH:MM format
  * No checks for conflicting time

## API

### Authorization Token Header
Using JWT

Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJTaW1wbGUgQVBJIiwiYWxnb3JpdGhtIjoiSFMyNTYifQ.aL9fcGXxlSGsEJ4_o9ed7gqBhbnYPbcPlO92RIaSjOc

### API V1
Routes and test example CURL calls
* POST /api/v1/request
  * Permitted JSON parameters: '{ customer: [:first_name, :last_name], vehicle: [:make,:model,:vin], time_slot: [:time] }'
  * curl -X POST -H "Content-Type: application/json" -H "Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJTaW1wbGUgQVBJIiwiYWxnb3JpdGhtIjoiSFMyNTYifQ.aL9fcGXxlSGsEJ4_o9ed7gqBhbnYPbcPlO92RIaSjOc" -d '{"customer":{ "first_name":"First", "last_name":"Last"},"vehicle":{"make":"Volvo","model":"245DL","vin":"SDHJSKHD324234"},"time_slot":{"time":"12:00"} }' http://0.0.0.0:3000/api/v1/request
* GET /api/1/customer
  * curl -X GET -H "Content-Type: application/json" -H "Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJTaW1wbGUgQVBJIiwiYWxnb3JpdGhtIjoiSFMyNTYifQ.aL9fcGXxlSGsEJ4_o9ed7gqBhbnYPbcPlO92RIaSjOc" http://0.0.0.0:3000/api/v1/customer
* GET /api/v1/vehicle
  * curl -X GET -H "Content-Type: application/json" -H "Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJTaW1wbGUgQVBJIiwiYWxnb3JpdGhtIjoiSFMyNTYifQ.aL9fcGXxlSGsEJ4_o9ed7gqBhbnYPbcPlO92RIaSjOc" http://0.0.0.0:3000/api/v1/vehicle
* GET /api/1/time
  * curl -X GET -H "Content-Type: application/json" -H "Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJTaW1wbGUgQVBJIiwiYWxnb3JpdGhtIjoiSFMyNTYifQ.aL9fcGXxlSGsEJ4_o9ed7gqBhbnYPbcPlO92RIaSjOc" http://0.0.0.0:3000/api/v1/time

## Linting, tests, type checking and audits
### RuboCop
```bash
rubocop
rubocop -a  # auto-fix safe offenses
```

## Run test cases
```bash
rspec
```

## Application audits
```bash
brakeman --no-pager
bundler-audit
```
