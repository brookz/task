FactoryGirl.define do
  factory :user do
    name "John"
    sequence(:email) { |n| "user#{n}@test.com" }
    password '123456'
    team
  end
end