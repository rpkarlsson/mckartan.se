require "ffaker"

FactoryBot.define do
  factory :point do |f|
    # association :section
    f.lng { FFaker::Geolocation.lng }
    f.lat { FFaker::Geolocation.lat }
  end
end
