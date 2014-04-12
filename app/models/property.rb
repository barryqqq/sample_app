class Property < ActiveRecord::Base
	belongs_to :user
	default_scope -> { order('created_at DESC') }
	#has_many :photos, as: :imageable

	has_many :users, :through => :collections

end
