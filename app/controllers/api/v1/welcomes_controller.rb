module Api::V1
  class WelcomesController < ApiController 
		def index 	
			if user_signed_in?
					@users = User.all
					render '/api/v1/welcomes/index.json'
			end     
		end
	end
end