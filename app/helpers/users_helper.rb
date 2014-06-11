module UsersHelper

	
	def add_or_change_avatar(user)
		
		if user.avatar_file_name != nil || user.fb_image != nil
			"Change your avatar"
		else
			"Add your avatar"
		end	
		
	end	

	def show_gender(gender)
		if gender == 1
			"Male"
		elsif gender == 0
			"Female"
		end		
	end	

	def show_language(lan)
		if lan == "en"
			"English"
		elsif lan == "ch"
			"中文"
		end
	end		
		
	def show_education(edu)
		if edu == "hs"
			"High School"
		elsif edu == "cc"
			"College Credit"
		elsif edu == "bd"
			"Bachelor's Degree"
		elsif edu == "md"
			"Master's Degree"
		elsif edu == "dd"
			"Doctorate Degree"	
		end			
	end

	def fb_id_or_connect(user)
		if user.uid != nil
			raw("<strong><a href='#{user.facebook_link}' target='_blank'>#{user.first_name}.#{user.last_name}</a></strong>")

		else
			link_to omniauth_authorize_path("user", "facebook") do 
			raw("<button class='btn btn-sm fb-color' type='button'><i class='fa fa-facebook-square fa-2x'></i> 
				<span class=''>&nbsp;&nbsp;CONNECT WITH FACEBOOK</span></button>") 
				  			
			end 

		end	
	end 				


end
