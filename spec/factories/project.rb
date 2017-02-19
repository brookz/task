FactoryGirl.define do
  factory :project do
    sequence(:title) { |n| "project-#{n}" }
    team 
  end
end