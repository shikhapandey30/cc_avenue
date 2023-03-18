class TransactionsController < ApplicationController
	skip_before_action :verify_authenticity_token

	def new
	end

	def create
	end

	def response_handler
	end

	def response1
		@data = CcavenuePayment.decrypted_data(params['encResp'])
		# Crypto.new.decrypt(params["encResp"], ENV["CCAVENUE_WORKING_KEY"])
		# head :ok
	end

	def response_cancel
		
	end
end


# def response1
# 		@data = CcavenuePayment.decrypted_data(params['encResp'])
# 		json_data = {}
# 		@data.split("&").each do |str|
# 			str_array = str.split("=")
# 			json_data[str_array[0]] = str_array[1] 
# 		end
# 		puts json_data
# 		head :ok
# 	end