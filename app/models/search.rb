class Search < ActiveRecord::Base
	def self.search(search)
		if search
			 

		else
			
			find(:all)

			
		end
	end	

end
