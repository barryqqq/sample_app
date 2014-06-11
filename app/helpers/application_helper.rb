module ApplicationHelper
	# return the full title on a per-page basis
	def full_title(page_title)
		base_title = "Around You and Me"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end	

	# return name of type
	def render_type(type)
		if type.to_f == 0 then 
			raw("<kbd>Rent</kbd>") 
			#raw("<span class='label label-default'>Rent</span>") 
		elsif type.to_f == 1
			raw("<span class='label label-success'>Shared Apt.</span>") 
		elsif type.to_f == 2
			raw("<span class='label label-warning'>Sublease</span>") 
		end						
	end	
	
	def render_gender(gender)
		if gender.to_f == 0 
			"None"
		elsif gender.to_f == 1
			"Women Only"
		else gender.to_f == 2
			"Men Only"	
		end	
	end	

	def render_pet(pet)
		if pet.to_f == 0 
			"No"
		elsif pet.to_f == 1
			"Cat"
		elsif pet.to_f == 2
			"Dog"
		else pet.to_f == 3
			"All kinds"	
		end	
	end	

	def price_on_type(price, category)

		if category.to_f == 2  #Sublease
			raw("<code> #{price} </code> /day")
		else
			raw("<code> #{price} </code> /month")
		end	

	end	

	def render_utilities(electricity, heat, internet)
		content = ""
		if ( !electricity && !heat && !internet)
			content = "Not included"
		else
			if (electricity)
				content += "Electricity "
			end	
			
			if (heat)
				content += "Heat "
			end	
			
			if (internet)
				content += "Internet"
			end	
		end							
	end


	def render_image
		if user_signed_in?
			if current_user.avatar_file_name != nil
				current_user.avatar.url(:thumb)
			elsif current_user.fb_image != nil
				current_user.fb_image
			end	
		end	
	end	

	

	
	
end
