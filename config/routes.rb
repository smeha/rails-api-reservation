Rails.application.routes.draw do
	namespace :api do
		namespace :v1, defaults: { format: 'json' } do
			resources :request, only: [:create]
			resources :customer, only: [:index]  
			resources :vehicle, only: [:index] 
			resources :time, only: [:index]  		
		end
	end
end
