module Api::V1
	class StoreController < ApiController
		def index
			@stores = Store.all
			render '/api/v1/store/index.json'
		end
		
		def show
			if user_signed_in?
				@store = Store.find_by(id: params[:id])
				render '/api/v1/store/show.json'
			end
		end
	end
end