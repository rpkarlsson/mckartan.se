class Section < ActiveRecord::Base

  belongs_to :user

  has_many  :points

  validates :user_id,
            :distance,
            :duration,
            :start_address,
            :end_address,
            :points,
            presence: true

end
