class User < ActiveRecord::Base

	has_many :microposts, dependent: :destroy
	has_many :properties, dependent: :destroy

	#has_many :properties, :through => :collections
	
	# This method associates the attribute ":avatar" with a file attachment
  	has_attached_file :avatar, 

  	
  	#:default_url => "/images/normal/missing.png",

  	
  	:storage => :s3,
  	:bucket => 'around_you_and_me',
  	:s3_credentials => "#{Rails.root}/config/s3.yml",
  	styles: {
    	mini: '32X32>',
    	thumb: '100x100>',
    	#square: '200x200#',
    	medium: '300x300>'
  	}

	
	
  	
	before_save { self.email = email.downcase }
	before_create :create_remember_token

	# Validate the attached image is image/jpg, image/png, etc
  	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

	validates :name, presence: true, length: {maximum: 50}

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false}
	
	has_secure_password
	validates :password, length: { minimum: 6 }

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end
	

	def User.hash(token)
    	Digest::SHA1.hexdigest(token.to_s)
  	end
	
	private

		def create_remember_token
			self.remember_token = User.hash(User.new_remember_token)
		end			


	
end
