module UsersHelper

	
	def add_or_change_avatar(user)
		
		if user.avatar_file_name != nil
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


end
