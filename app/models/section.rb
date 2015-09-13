class Section < ActiveRecord::Base

  belongs_to :user

  # Removes all dependent points with delete_all. Destroy was taking
  # too long. Will delete with SQL statement ignoring any
  # further callbacks from Point.
  has_many  :points, dependent: :delete_all

  validates :user_id,
            :distance,
            :duration,
            :start_address,
            :end_address,
            :points,
            presence: true

end
