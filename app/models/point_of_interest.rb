class PointOfInterest < ApplicationRecord
  belongs_to :user

  validates :user_id,
            :lng,
            :lat,
            presence: true
end
