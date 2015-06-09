require "faker"

FactoryGirl.define do
  factory :section do |f|
    user_id         { Faker::Number.digit }
    f.distance      { Faker::Number.number(4) }
    f.duration      { Faker::Number.number(4) }
    f.start_address { Faker::Address.street_address }
    f.end_address   { Faker::Address.street_address }
  end
end
