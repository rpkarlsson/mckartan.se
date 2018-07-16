require "ffaker"

FactoryBot.define do
  factory :user do |f|
    password = FFaker::Internet.password
    f.username { FFaker::Internet.user_name }
    f.email    { FFaker::Internet.email }
    f.password { password }
    f.password_confirmation { password }
  end

  factory :user_with_bad_confirmation, parent: :user do |f|
    f.password  { "misspelledpassword" }
  end

end
