require "faker"

FactoryGirl.define do
  factory :user do |f|
    password = Faker::Internet.password
    f.username                  { Faker::Internet.user_name }
    f.email                 { Faker::Internet.email }
    f.password              { password }
    f.password_confirmation { password }
  end

  factory :user_with_bad_confirmation, parent: :user do |f|
    f.password  { "misspelledpassword" }
  end

end

