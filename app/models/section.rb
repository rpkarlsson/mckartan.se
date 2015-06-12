class Section < ActiveRecord::Base

  belongs_to :user, class_name: "UsersEngine::User"

  has_many  :points

  validates :user_id,
            :distance,
            :duration,
            :start_address,
            :end_address,
            :points,
            presence: true

end
