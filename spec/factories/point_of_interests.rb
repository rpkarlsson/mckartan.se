require "ffaker"

FactoryBot.define do
  factory :point_of_interest do |p|
    association :user
    p.lng { FFaker::Geolocation.lng }
    p.lat { FFaker::Geolocation.lat }
  end
end
