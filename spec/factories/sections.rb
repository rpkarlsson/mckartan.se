require "faker"

FactoryBot.define do
  factory :section do |f|
#    f.user_id       { Faker::Number.digit }
    user
    f.distance      { Faker::Number.number(4) }
    f.duration      { Faker::Number.number(4) }
    f.start_address { Faker::Address.street_address }
    f.end_address   { Faker::Address.street_address }
    # association :points, factory: :points, strategy: :build

    # factory :section_with_points do
    #   transient do
    #     point_count 5
    #   end

    #   after(:build) do |route, evaluator|
    #     create_list :point, evaluator.point_count
    #   end
    # end
  end
end
