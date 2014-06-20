module UsersHelper

	
	def add_or_change_avatar(user)
		
		if user.avatar_file_name != nil || user.fb_image != nil
			t("users.show.change_avatar")
		else
			t('users.show.add_avatar')
		end	
		
	end	

	def show_gender(gender)
		if gender == 1
			t('form.male')
		elsif gender == 0
			t('form.female')
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
			t('users.show.high_school')
		elsif edu == "cc"
			t('users.show.college_credit')
		elsif edu == "bd"
			t('users.show.bachelor_degree')
		elsif edu == "md"
			t('users.show.master_degree')
		elsif edu == "dd"
			t('users.show.doctorate_degree')
		end			
	end

	def fb_id_or_connect(user)
		if user.uid != nil
			raw("<strong><a href='#{user.facebook_link}' target='_blank'>#{user.first_name}.#{user.last_name}</a></strong>")

		else
			link_to omniauth_authorize_path("user", "facebook") do 
			raw("<button class='btn btn-sm fb-color' type='button'><i class='fa fa-facebook-square fa-2x'></i> 
				<span class=''>&nbsp;&nbsp; #{ t('users.show.connect_w_fb') } </span></button>") 
				  			
			end 

		end	
	end 				


end
