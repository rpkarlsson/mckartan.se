class Section < ActiveRecord::Base

  has_many :points

  validates :user_id,
            :distance,
            :duration,
            :start_address,
            :end_address,
            :points,
            presence: true

end
