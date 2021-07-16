class Feed < ApplicationRecord
    mount_uploader :image, ImageUploader
    validates :content,  presence: true, length: { minimum: 4 }
end
