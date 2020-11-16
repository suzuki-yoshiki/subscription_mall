class Subscription < ApplicationRecord
  belongs_to :owner
  # has_many :images, dependent: :destroy
  # accepts_nested_attributes_for :images

  enum price: { "3,000"=> 0, "12,000"=> 1, "18,000"=> 2, "25,000"=> 3, "50,000"=> 4, "100,000"=> 5}
  attachment :image_subscription
end
