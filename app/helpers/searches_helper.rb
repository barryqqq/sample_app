module SearchesHelper


	def sortable(column, title = nil)
		title ||= column.titleize

		direction = (column == sort_column && sort_direction == 'asc') ? 'desc' : 'asc'
		link_to title, params.merge(:sort => column, :direction => direction, :page => nil)	

	end	

	def max_price(properties)
		properties.maximum(:price)
	end

	def slider_step(properties)

		step = properties.maximum(:price)
		
		if step.to_f < 200 then
			step = 10
		else
			step = 100		
		end	
	end	


	


	
end
