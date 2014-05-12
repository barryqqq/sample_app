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

	
	def sortable(column, title = nil, location = nil)
		title ||= column.titleize

		direction = (column == sort_column && sort_direction == 'asc') ? 'desc' : 'asc'
		link_to title, :sort => column, :direction => direction, :location => location

	end	

end
