class Photo < ActiveRecord::Base

	has_attached_file :image, 

  	#:default_url => "/images/normal/missing.png",
  	:storage => :s3,
  	:bucket => 'around_you_and_me',
    #:s3_credentials => "#{Rails.root}/config/s3.yml",
  	styles: {
    	
    	thumb: '100x100>',
    	medium: '400x300>'
  	}

  # Validate the attached image is image/jpg, image/png, etc
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  before_create :randomize_file_name 

  def image_url_thumb
    image.url(:thumb)
	end

	def image_url_medium
    image.url(:medium)
	end
    
  private

    def randomize_file_name
      extension = File.extname(image_file_name).downcase
      self.image.instance_write(:file_name, "#{Time.now.to_i.to_s}#{extension}")
    end
      


end
