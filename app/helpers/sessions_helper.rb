module SessionsHelper

	def current_location
	    @location ||= Geocoder.search(remote_ip)[0].address
	end
end
