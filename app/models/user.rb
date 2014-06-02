class User < ActiveRecord::Base


  # Include default devise modules. Others available are:
  # :confirmable, :lockable,  :timeoutable ,
  devise :database_authenticatable, :registerable, :validatable, :rememberable,
        :recoverable, :trackable, :confirmable
  devise :omniauthable, :omniauth_providers => [:facebook]  
         

	has_many :microposts, dependent: :destroy
	has_many :properties, dependent: :destroy

	has_many :collections, dependent: :destroy
	#has_many :properties, :through => :collections
	
	# This method associates the attribute ":avatar" with a file attachment
  	has_attached_file :avatar, 
  	#:default_url => "/images/normal/missing.png",
  	#:storage => :s3,
  	:bucket => 'around_you_and_me',
  	#:s3_credentials => "#{Rails.root}/config/s3.yml",
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

	#validates :name, presence: true, length: {maximum: 50}

	#VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	#validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false}
	
	#has_secure_password
	#validates :password, length: { minimum: 6 }




	#geocoder
	#geocoded_by :ip_address,
	#:latitude => :latitude, :longitude => :longitude
	#after_validation :geocode	


  




	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end
	

	def User.hash(token)
    	Digest::SHA1.hexdigest(token.to_s)

  	end

  	

	def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
  	user = User.where(:provider => auth.provider, :uid => auth.uid).first
  	if user
    		return user
  	else
    		registered_user = User.where(:email => auth.info.email).first
    		if registered_user
      		return registered_user
    		else

          # for gender
          if (auth.extra.raw_info.gender == 'male')
            gender = 1
          elsif (auth.extra.raw_info.gender == 'female')
            gender = 0
          else
            gender = nil 
          end    

      		user = User.create(name:auth.extra.raw_info.name,
                          provider:auth.provider,
                          uid:auth.uid,
                          email:auth.info.email,
                          password:Devise.friendly_token[0,20],
                          first_name:auth.info.first_name,
                          last_name:auth.info.last_name,
                          facebook_link:auth.extra.raw_info.link,
                          #location:auth.extra.raw_info.location,
                          gender:gender,
                          fb_image:auth.info.image
                        )
    		end   
		end

	end

  	
	
	private

		def create_remember_token
			self.remember_token = User.hash(User.new_remember_token)
		end	


		



	
end
