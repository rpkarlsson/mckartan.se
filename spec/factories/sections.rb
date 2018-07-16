require "ffaker"

FactoryBot.define do
  factory :section do |f|
    association :user
    f.distance      { rand }
    f.duration      { rand }
    f.start_address { FFaker::Address.street_address }
    f.end_address   { FFaker::Address.street_address }

    factory :section_with_points do
      transient do
        point_count 5
      end

      after(:build) do |section, evaluator|
        section.points = build_list(:point, evaluator.point_count, section: section)
      end
    end
  end
end
