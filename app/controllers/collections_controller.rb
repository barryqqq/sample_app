class CollectionsController < ApplicationController
	

	def add	
	  c = Collection.find_or_create_by(user_id: current_user.id, property_id: params[:id])

	  if c.save
	    render :nothing => true	
      end		
	end	
	
	def del	
      c = Collection.find_by(user_id: current_user.id, property_id: params[:id])
	  c.destroy
	  render :nothing => true

	end

	def collect
	  @c = Collection.where(user_id: current_user.id, property_id: params[:id])

	  respond_to do |format|
		format.json { render :json => @c.to_json()}
	  end	
	end	

end
