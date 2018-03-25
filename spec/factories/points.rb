require "faker"

FactoryBot.define do
  factory :point do |f|
    # before(:create) { f.section_id = FactoryBot.build(:section).id}
    f.section_id  { Faker::Number.digit }
    f.lng         { Faker::Address.longitude}
    f.lat         { Faker::Address.latitude }
  end
end
