## Installation and Environment Used
* Mac OSX Catalina
* Ruby through brew (the funky way now in Catalina)
  * ruby 2.7.2p137
* Rails 6.1.3.1
* PostgreSQL 13.1

### Additional Gems
JWT and CanCan for authorization handling and toking decoding

### Usage

`git clone https://github.com/smeha/rails-api-reservation`

`bundle install`

`rails db:create`

`rails db:migrate`

`rails s`


## About
Simple reservation API, that allows through an API call capture customer's information, vehicle information, and secure a time slot.

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
