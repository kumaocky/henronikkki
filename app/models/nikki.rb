class Nikki < ActiveRecord::Base
  belongs_to :user
  belongs_to :temple

  has_attached_file :image,
                    :styles => {
                        :thumb  => "100x100",
                        :medium => "280x>",
                        :large => "1000x>"
                    },
                    :storage => :s3,
                    :s3_region => "ap-northeast-1",
                    :s3_permissions => :private,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :path => ":attachment/:id/:style.:extension"

  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  def authenticated_image_url(style)
    image.s3_object(style).url_for(:read, :secure => true)
  end
end
