module PropertiesHelper

	
	def fb_share
		if user_signed_in?
			raw("<a href='#{facebook_share_property_path}' class='btn btn-lg' ><i class='fa fa-facebook fa-lg'></i></a>")
		end	
	end
end
