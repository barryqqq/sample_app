#Paperclip::Attachment.default_options[:storage] = :s3
#Paperclip::Attachment.default_options[:s3_protocol] = 'http'
#Paperclip::Attachment.default_options[:s3_credentials] =
#  { :bucket => ENV['around_you_and_me'],
#    :access_key_id => ENV['AKIAISIXGQLGCTCLR3DQ'],
#    :secret_access_key => ENV['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'] }


Paperclip::Attachment.default_options[:url] = ':s3_domain_url'
Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:style/:filename'

#Paperclip::Attachment.default_options[:s3_host_name] = 's3-us-west-2.amazonaws.com'