class Point < ActiveRecord::Base

  belongs_to :section

  validates :lng, :lat, presence: true
end
