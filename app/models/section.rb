class Section < ActiveRecord::Base

  validates :user_id,
            :distance,
            :duration,
            :start_address,
            :end_address,
            presence: true

end
