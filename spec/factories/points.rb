require "faker"

FactoryGirl.define do
  factory :point do |f|
    f.section_id  { Faker::Number.digit }
    f.lng         { Faker::Address.longitude}
    f.lat         { Faker::Address.latitude }
  end
end
